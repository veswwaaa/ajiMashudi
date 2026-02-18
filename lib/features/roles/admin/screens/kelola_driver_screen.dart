import 'package:flutter/material.dart';
import '../components/stat_card.dart';
import '../components/status_badge.dart';

class KelolaDriverScreen extends StatefulWidget {
  const KelolaDriverScreen({super.key});

  @override
  State<KelolaDriverScreen> createState() => _KelolaDriverScreenState();
}

class _KelolaDriverScreenState extends State<KelolaDriverScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Data dummy untuk drivers dengan toggle status
  final List<Map<String, dynamic>> _allDrivers = [
    {
      'name': 'Budi Santoso',
      'phone': '081234567890',
      'vehicle': 'B 1234 XYZ',
      'status': DriverStatus.sibuk,
      'rating': 4.8,
      'totalOrders': 245,
      'isActive': true,
    },
    {
      'name': 'Dedi Kusuma',
      'phone': '081234567891',
      'vehicle': 'B 5678 ABC',
      'status': DriverStatus.online,
      'rating': 4.6,
      'totalOrders': 189,
      'isActive': true,
    },
    {
      'name': 'Eko Prasetyo',
      'phone': '081234567892',
      'vehicle': 'B 9012 DEF',
      'status': DriverStatus.online,
      'rating': 4.9,
      'totalOrders': 312,
      'isActive': true,
    },
    {
      'name': 'Fajar Nugroho',
      'phone': '081234567893',
      'vehicle': 'B 3456 GHI',
      'status': DriverStatus.offline,
      'rating': 4.5,
      'totalOrders': 156,
      'isActive': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredDrivers {
    if (_searchController.text.isEmpty) return _allDrivers;

    final query = _searchController.text.toLowerCase();
    return _allDrivers.where((driver) {
      return driver['name'].toLowerCase().contains(query) ||
          driver['phone'].contains(query);
    }).toList();
  }

  int get _totalDriver => _allDrivers.length;
  int get _online =>
      _allDrivers.where((d) => d['status'] == DriverStatus.online).length;
  int get _sibuk =>
      _allDrivers.where((d) => d['status'] == DriverStatus.sibuk).length;
  int get _offline =>
      _allDrivers.where((d) => d['status'] == DriverStatus.offline).length;

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
              'Kelola Driver',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Kelola data driver',
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
            const SizedBox(height: 16),

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
                    title: 'Total Driver',
                    value: '$_totalDriver',
                    icon: Icons.people,
                    color: Colors.blue.shade600,
                  ),
                  StatCard(
                    title: 'Online',
                    value: '$_online',
                    icon: Icons.check_circle,
                    color: Colors.green.shade600,
                  ),
                  StatCard(
                    title: 'Sibuk',
                    value: '$_sibuk',
                    icon: Icons.delivery_dining,
                    color: Colors.orange.shade600,
                  ),
                  StatCard(
                    title: 'Offline',
                    value: '$_offline',
                    icon: Icons.cancel,
                    color: Colors.grey.shade600,
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
                  hintText: 'Cari nama atau no HP...',
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

            // Button Tambah Driver
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tambah Driver'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Tambah Driver'),
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

            // Drivers List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredDrivers.length,
              itemBuilder: (context, index) {
                final driver = _filteredDrivers[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Avatar
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.blue.shade100,
                              child: Icon(
                                Icons.person,
                                size: 32,
                                color: Colors.blue.shade700,
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Driver Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          driver['name'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      StatusBadge(
                                        status: driver['status'],
                                        fontSize: 11,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        driver['phone'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_shipping,
                                        size: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        driver['vehicle'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        const Divider(height: 1),
                        const SizedBox(height: 12),

                        // Stats Row
                        Row(
                          children: [
                            // Rating
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.amber.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${driver['rating']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Total Orders
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.receipt_long,
                                    size: 18,
                                    color: Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${driver['totalOrders']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Active Toggle
                            Row(
                              children: [
                                Text(
                                  'Aktif',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Switch(
                                  value: driver['isActive'],
                                  activeColor: Colors.green.shade600,
                                  onChanged: (bool value) {
                                    setState(() {
                                      driver['isActive'] = value;
                                      // Update status based on toggle
                                      if (value) {
                                        // If activated, set to online
                                        driver['status'] = DriverStatus.online;
                                      } else {
                                        // If deactivated, set to offline
                                        driver['status'] = DriverStatus.offline;
                                      }
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${driver['name']} ${value ? 'diaktifkan' : 'dinonaktifkan'}',
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
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
