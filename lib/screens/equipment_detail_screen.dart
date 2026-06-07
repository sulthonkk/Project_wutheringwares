import 'package:flutter/material.dart';
import '../models/equipment.dart';
import '../services/purchase_service.dart';

class EquipmentDetailScreen extends StatefulWidget {
  final Equipment equipment;

  const EquipmentDetailScreen({super.key, required this.equipment});

  @override
  State<EquipmentDetailScreen> createState() => _EquipmentDetailScreenState();
}

class _EquipmentDetailScreenState extends State<EquipmentDetailScreen> {
  int _quantity = 1;
  bool _isLoading = false;

  Future<void> _buy() async {
    setState(() => _isLoading = true);

    final result = await PurchaseService.createPurchase(
      widget.equipment.id,
      _quantity,
    );

    setState(() => _isLoading = false);

    if (result['success']) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Pembelian Berhasil'),
          content: Text(
            'Kamu membeli ${_quantity}x ${widget.equipment.name}\nTotal: Rp ${result['total_price']}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Pembelian gagal')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final equipment = widget.equipment;
    return Scaffold(
      appBar: AppBar(title: Text(equipment.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: equipment.image != null && equipment.image!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          equipment.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.shield, size: 80),
                        ),
                      )
                    : const Center(child: Icon(Icons.shield, size: 80)),
            ),
            const SizedBox(height: 24),
            Text(equipment.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(equipment.type,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 16),
            Text(equipment.description,
                style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp ${equipment.price.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text('Stok: ${equipment.stock}',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Jumlah:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: _quantity > 1
                      ? () => setState(() => _quantity--)
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$_quantity', style: const TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: _quantity < equipment.stock
                      ? () => setState(() => _quantity++)
                      : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: equipment.stock == 0 || _isLoading ? null : _buy,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        equipment.stock == 0 ? 'Stok Habis' : 'Beli Sekarang',
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}