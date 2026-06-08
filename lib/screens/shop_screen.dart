import 'package:flutter/material.dart';
import '../models/equipment.dart';
import '../models/terminal_supply.dart';
import '../services/equipment_service.dart';
import '../services/terminal_supply_service.dart';
import 'equipment_detail_screen.dart';
import 'terminal_supply_detail_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with SingleTickerProviderStateMixin {
  List<Equipment> _equipmentList = [];
  List<TerminalSupply> _terminalSupplyList = [];
  bool _isLoading = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final equipment = await EquipmentService.getAllEquipment();
      final supplies = await TerminalSupplyService.getAllTerminalSupplies();
      setState(() {
        _equipmentList = equipment;
        _terminalSupplyList = supplies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildGrid(List items, bool isEquipment) {
    if (items.isEmpty) {
      return const Center(child: Text('Belum ada item', style: TextStyle(color: Colors.white)));
    }
    return RefreshIndicator(
      onRefresh: _loadData,
      color: const Color(0xFFD4AF37),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final name = isEquipment ? (item as Equipment).name : (item as TerminalSupply).name;
          final type = isEquipment ? (item as Equipment).type : (item as TerminalSupply).category;
          final price = isEquipment ? (item as Equipment).price : (item as TerminalSupply).price;
          final image = isEquipment ? (item as Equipment).image : (item as TerminalSupply).image;

          return GestureDetector(
            onTap: () {
              if (isEquipment) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => EquipmentDetailScreen(equipment: item as Equipment),
                ));
              } else {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TerminalSupplyDetailScreen(item: item as TerminalSupply),
                ));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2A2A)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      color: const Color(0xFF111111),
                      child: image != null && image.isNotEmpty
                          ? Image.network(
                              image,
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                isEquipment ? Icons.shield : Icons.inventory,
                                color: const Color(0xFFD4AF37),
                                size: 48,
                              ),
                            )
                          : Icon(
                              isEquipment ? Icons.shield : Icons.inventory,
                              color: const Color(0xFFD4AF37),
                              size: 48,
                            ),
                    ),
                  ),
                  Container(height: 1, color: const Color(0xFF2A2A2A)),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text(type,
                            style: const TextStyle(
                                fontSize: 11, color: Color(0xFF888888))),
                        const SizedBox(height: 4),
                        Text('Rp ${price.toStringAsFixed(0)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFFD4AF37))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
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
                    'https://static.wikia.nocookie.net/wutheringwaves/images/8/8c/Resonator_Iuno.png/revision/latest/scale-to-width-down/250?cb=20250827031142',
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
                      Text('Available', style: TextStyle(color: Color(0xFF888888), fontSize: 14)),
                      Text('Items', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 28, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: const Color(0xFF1A1A1A),
            child: Column(
              children: [
                Container(height: 1, color: const Color(0xFF2A2A2A)),
                TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xFFD4AF37),
                  labelColor: const Color(0xFFD4AF37),
                  unselectedLabelColor: const Color(0xFF888888),
                  tabs: const [
                    Tab(text: 'Equipment'),
                    Tab(text: 'Terminal Supplies'),
                  ],
                ),
                Container(height: 1, color: const Color(0xFF2A2A2A)),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)))
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildGrid(_equipmentList, true),
                      _buildGrid(_terminalSupplyList, false),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}