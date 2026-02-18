import 'package:flutter/material.dart';
import '../components/order_card_admin.dart';

class DataOrderScreen extends StatefulWidget {
  const DataOrderScreen({super.key});

  @override
  State<DataOrderScreen> createState() => _DataOrderScreenState();
}

class _DataOrderScreenState extends State<DataOrderScreen> {
  String _selectedStatus = 'Semua Status';
  final TextEditingController _searchController = TextEditingController();

  // Data dummy untuk orders
  final List<Map<String, dynamic>> _allOrders = [
    {
      'orderId': 'ORD-001',
      'customerName': 'Ahmad Rizki',
      'driverName': 'Budi Santoso',
      'pickupAddress': 'Jl. Sudirman No. 45, Jakarta Selatan',
      'deliveryAddress': 'Jl. Gatot Subroto No. 12, Jakarta Pusat',
      'status': OrderStatus.selesai,
      'date': '2 Feb 2026',
      'price': 'Rp 175.000',
    },
    {
      'orderId': 'ORD-002',
      'customerName': 'Siti Nurhaliza',
      'driverName': 'Dedi Kusuma',
      'pickupAddress': 'Jl. Kemang Raya No. 20, Jakarta Selatan',
      'deliveryAddress': 'Jl. Malah Selatan No. 88, Jakarta Utara',
      'status': OrderStatus.selesai,
      'date': '1 Feb 2026',
      'price': 'Rp 285.000',
    },
    {
      'orderId': 'ORD-003',
      'customerName': 'Rudi Hartono',
      'driverName': null,
      'pickupAddress': 'Jl. Thamrin No. 10, Jakarta Pusat',
      'deliveryAddress': 'Jl. BSD Raya No. 55, Tangerang',
      'status': OrderStatus.menunggu,
      'date': '2 Feb 2026',
      'price': 'Rp 350.000',
    },
    {
      'orderId': 'ORD-004',
      'customerName': 'Ahmad Rizki',
      'driverName': 'Eko Prasetyo',
      'pickupAddress': 'Jl. Senayan No. 5, Jakarta Selatan',
      'deliveryAddress': 'Jl. Kelapa Gading No. 100, Jakarta Utara',
      'status': OrderStatus.selesai,
      'date': '30 Jan 2026',
      'price': 'Rp 220.000',
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    List<Map<String, dynamic>> filtered = _allOrders;

    // Filter by status
    if (_selectedStatus != 'Semua Status') {
      OrderStatus? targetStatus;
      if (_selectedStatus == 'Menunggu') targetStatus = OrderStatus.menunggu;
      if (_selectedStatus == 'Dalam Perjalanan')
        targetStatus = OrderStatus.dalamPerjalanan;
      if (_selectedStatus == 'Selesai') targetStatus = OrderStatus.selesai;
      if (_selectedStatus == 'Dibatalkan')
        targetStatus = OrderStatus.dibatalkan;

      if (targetStatus != null) {
        filtered = filtered
            .where((order) => order['status'] == targetStatus)
            .toList();
      }
    }

    // Filter by search
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      filtered = filtered.where((order) {
        return order['orderId'].toLowerCase().contains(query) ||
            order['customerName'].toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
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
              'Data Order',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Kelola semua pesanan',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Cari order ID atau customer...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                    filled: true,
                    fillColor: Colors.grey.shade50,
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

                const SizedBox(height: 12),

                // Status Filter
                Row(
                  children: [
                    Text(
                      'Semua Status',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedStatus,
                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey.shade600,
                            ),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade800,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            dropdownColor: Colors.white,
                            elevation: 4,
                            items:
                                [
                                  'Semua Status',
                                  'Menunggu',
                                  'Dalam Perjalanan',
                                  'Selesai',
                                  'Dibatalkan',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _selectedStatus = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Order Count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menampilkan ${_filteredOrders.length} dari ${_allOrders.length} order',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Export data order'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.file_download, size: 18),
                      label: const Text('Export'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue.shade700,
                        side: BorderSide(color: Colors.blue.shade700),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list, size: 18),
                      label: const Text('Selanjutnya'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue.shade700,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Orders List
          Expanded(
            child: _filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada order',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: _filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = _filteredOrders[index];
                      return OrderCardAdmin(
                        orderId: order['orderId'],
                        customerName: order['customerName'],
                        driverName: order['driverName'],
                        pickupAddress: order['pickupAddress'],
                        deliveryAddress: order['deliveryAddress'],
                        status: order['status'],
                        date: order['date'],
                        price: order['price'],
                        onTap: () {
                          // Handle order tap
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Detail order: ${order['orderId']}',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
