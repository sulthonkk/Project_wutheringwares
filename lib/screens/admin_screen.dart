import 'package:flutter/material.dart';
import '../models/equipment.dart';
import '../services/equipment_service.dart';
import '../services/auth_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Equipment> _equipmentList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEquipment();
  }

  Future<void> _loadEquipment() async {
    try {
      final data = await EquipmentService.getAllEquipment();
      setState(() {
        _equipmentList = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    await AuthService.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _showEquipmentForm({Equipment? equipment}) {
    final nameController = TextEditingController(text: equipment?.name ?? '');
    final typeController = TextEditingController(text: equipment?.type ?? '');
    final descController = TextEditingController(text: equipment?.description ?? '');
    final stockController = TextEditingController(text: equipment?.stock.toString() ?? '');
    final priceController = TextEditingController(text: equipment?.price.toString() ?? '');
    final imageController = TextEditingController(text: equipment?.image ?? '');
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24, right: 24, top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                equipment == null ? 'Tambah Equipment' : 'Edit Equipment',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Nama harus diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Tipe', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Tipe harus diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: stockController,
                decoration: const InputDecoration(labelText: 'Stok', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Stok harus diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Harga', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Harga harus diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: imageController,
                decoration: const InputDecoration(labelText: 'URL Gambar', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) return;
                  final data = {
                    'name': nameController.text,
                    'type': typeController.text,
                    'description': descController.text,
                    'stock': int.parse(stockController.text),
                    'price': double.parse(priceController.text),
                    'image': imageController.text,
                  };
                  if (equipment == null) {
                    await EquipmentService.createEquipment(data);
                  } else {
                    await EquipmentService.updateEquipment(equipment.id, data);
                  }
                  Navigator.pop(context);
                  _loadEquipment();
                },
                child: Text(equipment == null ? 'Tambah' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteEquipment(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Equipment'),
        content: const Text('Yakin ingin menghapus equipment ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              await EquipmentService.deleteEquipment(id);
              Navigator.pop(context);
              _loadEquipment();
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEquipmentForm(),
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _equipmentList.isEmpty
              ? const Center(child: Text('Belum ada equipment'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _equipmentList.length,
                  itemBuilder: (context, index) {
                    final equipment = _equipmentList[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: equipment.image != null && equipment.image!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              equipment.image!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.shield, size: 40),
                            ),
                          )
                        : const Icon(Icons.shield, size: 40),
                        title: Text(equipment.name,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${equipment.type} • Stok: ${equipment.stock}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showEquipmentForm(equipment: equipment),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteEquipment(equipment.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}