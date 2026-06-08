import 'package:flutter/material.dart';
import '../models/terminal_supply.dart';
import '../services/purchase_service.dart';

class TerminalSupplyDetailScreen extends StatefulWidget {
  final TerminalSupply item;

  const TerminalSupplyDetailScreen({super.key, required this.item});

  @override
  State<TerminalSupplyDetailScreen> createState() => _TerminalSupplyDetailScreenState();
}

class _TerminalSupplyDetailScreenState extends State<TerminalSupplyDetailScreen> {
  int _quantity = 1;
  bool _isLoading = false;

  Future<void> _buy() async {
    setState(() => _isLoading = true);

    final result = await PurchaseService.createPurchase(
      terminalSupplyId: widget.item.id,
      quantity: _quantity,
      itemType: 'terminal_supply',
    );

    setState(() => _isLoading = false);

    if (result['success']) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Pembelian Berhasil'),
          content: Text(
            'Kamu membeli ${_quantity}x ${widget.item.name}\nTotal: Rp ${result['total_price']}',
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
    final item = widget.item;
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
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
              child: item.image != null && item.image!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.inventory, size: 80),
                      ),
                    )
                  : const Center(child: Icon(Icons.inventory, size: 80)),
            ),
            const SizedBox(height: 24),
            Text(item.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(item.category,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 16),
            Text(item.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp ${item.price.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text('Stok: ${item.stock}',
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
                  onPressed: _quantity < item.stock
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
                onPressed: item.stock == 0 || _isLoading ? null : _buy,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        item.stock == 0 ? 'Stok Habis' : 'Beli Sekarang',
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