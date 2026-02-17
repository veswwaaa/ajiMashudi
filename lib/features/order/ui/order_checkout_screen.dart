import 'package:flutter/material.dart';
import 'package:ajimashudi/shared/models/vehicle_type.dart';
import 'package:ajimashudi/shared/models/driver_info.dart';
import 'package:ajimashudi/shared/widgets/address_field.dart';
import 'package:ajimashudi/shared/widgets/vehicle_selection_card.dart';
import 'package:ajimashudi/shared/widgets/payment_method_button.dart';
import 'order_tracking_screen.dart';

class OrderCheckoutScreen extends StatefulWidget {
  final VehicleType selectedVehicle;
  final String pickupAddress;
  final String deliveryAddress;
  final double distance;
  final int duration;

  const OrderCheckoutScreen({
    super.key,
    required this.selectedVehicle,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.distance,
    required this.duration,
  });

  @override
  State<OrderCheckoutScreen> createState() => _OrderCheckoutScreenState();
}

class _OrderCheckoutScreenState extends State<OrderCheckoutScreen> {
  late TextEditingController _pickupController;
  late TextEditingController _deliveryController;
  String _selectedPayment = 'e-wallet';
  int _selectedVehicleIndex = 2; // Default to "Besar"

  final List<VehicleType> vehicles = [
    VehicleType(
      name: 'Kecil',
      capacity: 'Kapasitas 1.5 Ton',
      price: 'Rp 100.000',
      icon: Icons.local_shipping_outlined,
    ),
    VehicleType(
      name: 'Sedang',
      capacity: 'Kapasitas 3 Ton',
      price: 'Rp 150.000',
      icon: Icons.local_shipping_outlined,
    ),
    VehicleType(
      name: 'Besar',
      capacity: 'Kapasitas 5 Ton',
      price: 'Rp 200.000',
      icon: Icons.local_shipping_outlined,
    ),
  ];

  final List<Map<String, dynamic>> vehiclePrices = [
    {'name': 'Kecil', 'basePrice': 100000, 'perKm': 5000},
    {'name': 'Sedang', 'basePrice': 150000, 'perKm': 7500},
    {'name': 'Besar', 'basePrice': 200000, 'perKm': 10000},
  ];

  @override
  void initState() {
    super.initState();
    _pickupController = TextEditingController(text: widget.pickupAddress);
    _deliveryController = TextEditingController(text: widget.deliveryAddress);
  }

  double _getBasePrice() {
    return vehiclePrices[_selectedVehicleIndex]['basePrice'].toDouble();
  }

  double _getDistancePrice() {
    return (widget.distance * vehiclePrices[_selectedVehicleIndex]['perKm'])
        .toDouble();
  }

  double _getTotalPrice() {
    return _getBasePrice() + _getDistancePrice();
  }

  String _formatCurrency(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pesan Kendaraan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Address Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Pickup Address
                  AddressField(
                    label: 'Alamat Penjemputan',
                    address: widget.pickupAddress,
                    icon: Icons.location_on,
                    controller: _pickupController,
                  ),
                  const SizedBox(height: 16),
                  // Delivery Address
                  AddressField(
                    label: 'Alamat Tujuan',
                    address: widget.deliveryAddress,
                    icon: Icons.location_on,
                    controller: _deliveryController,
                  ),
                  const SizedBox(height: 16),
                  // Estimation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Estimasi',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${widget.distance.toStringAsFixed(1)} km',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            '',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '~${widget.duration} menit',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Vehicle Selection Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pilih Kendaraan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: List.generate(
                      vehicles.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: VehicleSelectionCard(
                          vehicle: vehicles[index],
                          price:
                              vehiclePrices[index]['price'] ??
                              vehicles[index].price,
                          isSelected: index == _selectedVehicleIndex,
                          onTap: () {
                            setState(() {
                              _selectedVehicleIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Payment Method Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: PaymentMethodButton(
                          icon: Icons.account_balance_wallet,
                          label: 'E-Wallet',
                          isSelected: _selectedPayment == 'e-wallet',
                          onTap: () {
                            setState(() {
                              _selectedPayment = 'e-wallet';
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PaymentMethodButton(
                          icon: Icons.credit_card_outlined,
                          label: 'Bank',
                          isSelected: _selectedPayment == 'bank',
                          onTap: () {
                            setState(() {
                              _selectedPayment = 'bank';
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PaymentMethodButton(
                          icon: Icons.attach_money,
                          label: 'Tunai',
                          isSelected: _selectedPayment == 'cash',
                          onTap: () {
                            setState(() {
                              _selectedPayment = 'cash';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Price Details Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rincian Biaya',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Biaya Dasar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Biaya Dasar',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        _formatCurrency(_getBasePrice()),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Jarak
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jarak (${widget.distance.toStringAsFixed(1)} km × Rp ${vehiclePrices[_selectedVehicleIndex]['perKm']})',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        _formatCurrency(_getDistancePrice()),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 12),
                  // Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        _formatCurrency(_getTotalPrice()),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
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
                  orderId: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
                  driver: driver,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Konfirmasi Pesanan • ${_formatCurrency(_getTotalPrice())}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _deliveryController.dispose();
    super.dispose();
  }
}

