import 'package:flutter/material.dart';
import '../components/stat_card.dart';

enum VehicleStatus { tersedia, digunakan, maintenance }

class KelolaUnitScreen extends StatefulWidget {
  const KelolaUnitScreen({super.key});

  @override
  State<KelolaUnitScreen> createState() => _KelolaUnitScreenState();
}

class _KelolaUnitScreenState extends State<KelolaUnitScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Data dummy untuk units
  final List<Map<String, dynamic>> _allUnits = [
    {
      'plateNumber': 'B 1234 XYZ',
      'type': 'Sedang (3T)',
      'capacity': '3 Ton',
      'status': VehicleStatus.digunakan,
      'driver': 'DRV-001',
    },
    {
      'plateNumber': 'B 5678 ABC',
      'type': 'Besar (5T)',
      'capacity': '5 Ton',
      'status': VehicleStatus.digunakan,
      'driver': 'DRV-002',
    },
    {
      'plateNumber': 'B 9012 DEF',
      'type': 'Kecil (1.5T)',
      'capacity': '1.5 Ton',
      'status': VehicleStatus.digunakan,
      'driver': 'DRV-003',
    },
    {
      'plateNumber': 'B 3456 GHI',
      'type': 'Sedang (3T)',
      'capacity': '3 Ton',
      'status': VehicleStatus.tersedia,
      'driver': '-',
    },
    {
      'plateNumber': 'B 7890 JKL',
      'type': 'Besar (5T)',
      'capacity': '5 Ton',
      'status': VehicleStatus.maintenance,
      'driver': '-',
    },
  ];

  List<Map<String, dynamic>> get _filteredUnits {
    if (_searchController.text.isEmpty) return _allUnits;

    final query = _searchController.text.toLowerCase();
    return _allUnits.where((unit) {
      return unit['plateNumber'].toLowerCase().contains(query) ||
          unit['type'].toLowerCase().contains(query);
    }).toList();
  }

  int get _totalUnit => _allUnits.length;
  int get _tersedia =>
      _allUnits.where((u) => u['status'] == VehicleStatus.tersedia).length;
  int get _digunakan =>
      _allUnits.where((u) => u['status'] == VehicleStatus.digunakan).length;
  int get _maintenance =>
      _allUnits.where((u) => u['status'] == VehicleStatus.maintenance).length;

  Color _getStatusColor(VehicleStatus status) {
    switch (status) {
      case VehicleStatus.tersedia:
        return Colors.green.shade400;
      case VehicleStatus.digunakan:
        return Colors.orange.shade400;
      case VehicleStatus.maintenance:
        return Colors.red.shade400;
    }
  }

  String _getStatusLabel(VehicleStatus status) {
    switch (status) {
      case VehicleStatus.tersedia:
        return 'Tersedia';
      case VehicleStatus.digunakan:
        return 'Digunakan';
      case VehicleStatus.maintenance:
        return 'Maintenance';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kelola Unit',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Kelola armada kendaraan',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Statistics Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  StatCard(
                    title: 'Total Unit',
                    value: '$_totalUnit',
                    icon: Icons.local_shipping,
                    color: Colors.blue.shade600,
                  ),
                  StatCard(
                    title: 'Tersedia',
                    value: '$_tersedia',
                    icon: Icons.check_circle,
                    color: Colors.green.shade600,
                  ),
                  StatCard(
                    title: 'Digunakan',
                    value: '$_digunakan',
                    icon: Icons.delivery_dining,
                    color: Colors.orange.shade600,
                  ),
                  StatCard(
                    title: 'Maintenance',
                    value: '$_maintenance',
                    icon: Icons.build,
                    color: Colors.red.shade600,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Cari plat nomor...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.blue.shade700,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Button Tambah Unit
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tambah Unit'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Tambah Unit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Table Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Plat Nomor',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Tipe',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Kapasitas',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Driver',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(
                      'Aksi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Units List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredUnits.length,
              itemBuilder: (context, index) {
                final unit = _filteredUnits[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          unit['plateNumber'],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          unit['type'],
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          unit['capacity'],
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(unit['status']),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _getStatusLabel(unit['status']),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          unit['driver'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Edit unit: ${unit['plateNumber']}',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.blue.shade600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Hapus unit: ${unit['plateNumber']}',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: Colors.red.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
