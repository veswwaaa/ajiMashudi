import 'package:flutter/material.dart';
import 'package:ajimashudi/shared/widgets/order_card.dart';
import 'order_tracking_screen.dart';
import 'package:ajimashudi/shared/models/driver_info.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  String _selectedTab = 'Semua';

  // Sample order data
  final List<Map<String, dynamic>> _allOrders = [
    {
      'id': 'ORD-001',
      'status': 'Dalam Perjalanan',
      'statusColor': Colors.blue,
      'from': 'Jl. Sudirman No. 45, Jakarta Selatan',
      'to': 'Jl. Gatot Subroto No. 12, Jakarta Pusat',
      'price': 'Rp 175.000',
      'distance': '8.5 km',
      'duration': '25 menit',
      'date': '2 Feb 2026',
      'type': 'Aktif',
    },
    {
      'id': 'ORD-002',
      'status': 'Selesai',
      'statusColor': Colors.green,
      'from': 'Jl. Kemang Raya No. 20, Jakarta Selatan',
      'to': 'Jl. Pluit Selatan No. 88, Jakarta Utara',
      'price': 'Rp 285.000',
      'distance': '15.2 km',
      'duration': '45 menit',
      'date': '1 Feb 2026',
      'type': 'Selesai',
    },
    {
      'id': 'ORD-003',
      'status': 'Menunggu',
      'statusColor': Colors.orange,
      'from': 'Jl. Thamrin No. 10, Jakarta Pusat',
      'to': 'Jl. BSD Raya No. 55, Tangerang',
      'price': 'Rp 350.000',
      'distance': '22 km',
      'duration': '60 menit',
      'date': '2 Feb 2026',
      'type': 'Aktif',
    },
    {
      'id': 'ORD-004',
      'status': 'Selesai',
      'statusColor': Colors.green,
      'from': 'Jl. Senayan No. 5, Jakarta Selatan',
      'to': 'Jl. Kelapa Gading No. 100, Jakarta Utara',
      'price': 'Rp 220.000',
      'distance': '18 km',
      'duration': '50 menit',
      'date': '30 Jan 2026',
      'type': 'Selesai',
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedTab == 'Semua') {
      return _allOrders;
    } else if (_selectedTab == 'Aktif') {
      return _allOrders.where((order) => order['type'] == 'Aktif').toList();
    } else {
      return _allOrders.where((order) => order['type'] == 'Selesai').toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Riwayat Pesanan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Semua', 'Aktif', 'Selesai'].map((tab) {
                final isSelected = _selectedTab == tab;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = tab;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        tab,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected ? Colors.blue : Colors.grey,
                        ),
                      ),
                      if (isSelected)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          width: 30,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 0),
          // Order List
          Expanded(
            child: _filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_shipping_outlined,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada pesanan',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = _filteredOrders[index];
                      return GestureDetector(
                        onTap: order['type'] == 'Aktif'
                            ? () {
                                final driver = DriverInfo(
                                  id: 'DR-001',
                                  name: 'Budi Santoso',
                                  plateNumber: 'B 1234 XYZ',
                                  rating: 4.8,
                                  totalRides: 125,
                                  isOnline: true,
                                  vehicleType: 'Box Truck',
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderTrackingScreen(
                                      orderId: order['id'],
                                      driver: driver,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        child: OrderCard(
                          orderId: order['id'],
                          status: order['status'],
                          statusColor: order['statusColor'],
                          fromAddress: order['from'],
                          toAddress: order['to'],
                          price: order['price'],
                          distance: order['distance'],
                          duration: order['duration'],
                          date: order['date'],
                          onOrderLagiPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Pesan lagi: ${order['id']}'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

