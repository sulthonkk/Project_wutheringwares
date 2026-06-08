import 'package:flutter/material.dart';
import '../services/purchase_service.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  List<dynamic> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final data = await PurchaseService.getPurchaseHistory();
      setState(() {
        _history = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Column(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xFF1A1A1A)),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Image.network(
                    'https://static.wikia.nocookie.net/wutheringwaves/images/d/da/Resonator_Shorekeeper.png/revision/latest/scale-to-width-down/250?cb=20240929033648',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const SizedBox(),
                  ),
                ),
                const Positioned(
                  left: 24,
                  top: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Purchase', style: TextStyle(color: Color(0xFF888888), fontSize: 14)),
                      Text('History', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 28, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)))
                : _history.isEmpty
                    ? const Center(
                        child: Text('Belum ada riwayat pembelian',
                            style: TextStyle(color: Color(0xFF888888))))
                    : RefreshIndicator(
                        onRefresh: _loadHistory,
                        color: const Color(0xFFD4AF37),
                        child: GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.72,
                          ),
                          itemCount: _history.length,
                          itemBuilder: (context, index) {
                            final item = _history[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFF2A2A2A)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: Container(
                                      height: 110,
                                      width: double.infinity,
                                      color: const Color(0xFF111111),
                                      child: item['image'] != null &&
                                              item['image'].toString().isNotEmpty
                                          ? Image.network(
                                              item['image'],
                                              fit: BoxFit.contain,
                                              errorBuilder: (context, error, stackTrace) =>
                                                  const Icon(Icons.inventory,
                                                      color: Color(0xFFD4AF37), size: 40),
                                            )
                                          : const Icon(Icons.inventory,
                                              color: Color(0xFFD4AF37), size: 40),
                                    ),
                                  ),
                                  Container(height: 1, color: const Color(0xFF2A2A2A)),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item['item_name'] ?? '-',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: Colors.white),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                        Text('${item['type']} • Qty: ${item['quantity']}',
                                            style: const TextStyle(
                                                fontSize: 10, color: Color(0xFF888888))),
                                        const SizedBox(height: 4),
                                        Text('Rp ${item['total_price']}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                                color: Color(0xFFD4AF37))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}