import 'package:flutter/material.dart';
import '../models/equipment.dart';
import '../models/terminal_supply.dart';
import '../services/equipment_service.dart';
import '../services/terminal_supply_service.dart';
import '../services/auth_service.dart';
import 'equipment_detail_screen.dart';
import 'terminal_supply_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Equipment> _equipmentList = [];
  List<TerminalSupply> _terminalSupplyList = [];
  bool _isLoading = true;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final user = await AuthService.getCurrentUser();
      final equipment = await EquipmentService.getAllEquipment();
      final supplies = await TerminalSupplyService.getAllTerminalSupplies();
      equipment.shuffle();
      supplies.shuffle();
      setState(() {
        _userName = user?.name ?? 'Rover';
        _equipmentList = equipment.take(6).toList();
        _terminalSupplyList = supplies.take(6).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildHorizontalCard(dynamic item, bool isEquipment) {
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
        width: 130,
        margin: const EdgeInsets.only(right: 12),
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
              child: image != null && image.isNotEmpty
                  ? Image.network(
                      image,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 100,
                        color: const Color(0xFF2A2A2A),
                        child: Icon(
                          isEquipment ? Icons.shield : Icons.inventory,
                          color: const Color(0xFFD4AF37),
                          size: 36,
                        ),
                      ),
                    )
                  : Container(
                      height: 100,
                      color: const Color(0xFF2A2A2A),
                      child: Icon(
                        isEquipment ? Icons.shield : Icons.inventory,
                        color: const Color(0xFFD4AF37),
                        size: 36,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text(type,
                      style: const TextStyle(fontSize: 10, color: Color(0xFF888888))),
                  const SizedBox(height: 4),
                  Text('Rp ${price.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD4AF37))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)))
          : RefreshIndicator(
              onRefresh: _loadData,
              color: const Color(0xFFD4AF37),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner
                    Container(
                      height: 160,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1A1A1A),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Image.network(
                              'https://oyster.ignimgs.com/mediawiki/apis.ign.com/wuthering-waves/3/30/Rover-havoc-male-icon.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => const SizedBox(),
                            ),
                          ),
                          Positioned(
                            left: 24,
                            top: 0,
                            bottom: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Welcome back,',
                                    style: TextStyle(color: Color(0xFF888888), fontSize: 14)),
                                Text(_userName,
                                    style: const TextStyle(
                                        color: Color(0xFFD4AF37),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Trending Equipment
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Trending Equipment',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 185,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: _equipmentList.length,
                        itemBuilder: (context, index) =>
                            _buildHorizontalCard(_equipmentList[index], true),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Trending Supply
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Trending Supply',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 185,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: _terminalSupplyList.length,
                        itemBuilder: (context, index) =>
                            _buildHorizontalCard(_terminalSupplyList[index], false),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }
}