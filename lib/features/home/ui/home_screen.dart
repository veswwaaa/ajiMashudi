import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ajimashudi/shared/models/vehicle_type.dart';
import 'package:ajimashudi/shared/models/location_marker.dart';
import 'package:ajimashudi/shared/widgets/vehicle_card.dart';
import 'package:ajimashudi/shared/widgets/google_map_widget.dart';
import 'package:ajimashudi/features/order/ui/order_checkout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedVehicle = 1;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  String _pickupAddress = 'Jl. Sudirman No. 45, Jakarta Selatan';
  String _deliveryAddress = 'Jl. Gatot Subroto No. 12, Jakarta Pusat';
  double _distance = 8.5;
  int _duration = 25;

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

  static const LatLng _defaultLocation = LatLng(-6.2088, 106.8456);
  late List<LocationMarker> _mapMarkers;

  @override
  void initState() {
    super.initState();
    _initializeMapMarkers();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initializeMapMarkers() {
    _mapMarkers = [
      LocationMarker(
        id: 'user_location',
        position: _defaultLocation,
        title: 'Lokasi Anda',
        description: 'Posisi Anda saat ini',
        type: MarkerType.userLocation,
      ),
      LocationMarker(
        id: 'pickup_1',
        position: const LatLng(-6.2100, 106.8500),
        title: 'Toko A',
        description: 'Titik Jemput Barang',
        type: MarkerType.pickupPoint,
      ),
      LocationMarker(
        id: 'delivery_1',
        position: const LatLng(-6.2050, 106.8400),
        title: 'Rumah Pelanggan',
        description: 'Titik Pengiriman',
        type: MarkerType.deliveryPoint,
      ),
      LocationMarker(
        id: 'vehicle_1',
        position: const LatLng(-6.2120, 106.8480),
        title: 'Kendaraan Sedang',
        description: 'Kendaraan Pengiriman',
        type: MarkerType.vehicle,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map with gradient overlay
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Stack(
              children: [
                // GoogleMapWidget(
                //   markers: _mapMarkers,
                //   initialPosition: _defaultLocation,
                //   onMarkerTap: (marker) {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //         content: Text('${marker.title}: ${marker.description}'),
                //         behavior: SnackBarBehavior.floating,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         margin: const EdgeInsets.all(16),
                //       ),
                //     );
                //   },
                // ),
                // Gradient overlay at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.8),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Main content
          DraggableScrollableSheet(
            initialChildSize: 0.58,
            minChildSize: 0.58,
            maxChildSize: 0.9,
            builder: (context, scrollController) => FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      // Handle bar
                      Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 8),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      // Search bar with gradient
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [Colors.blue.shade50, Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Mau kirim kemana?',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 15,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Container(
                                margin: const EdgeInsets.all(12),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.account_circle,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Vehicle selection section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.local_shipping,
                                    color: Colors.blue.shade700,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Pilih Jenis Kendaraan',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: List.generate(
                                vehicles.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: AnimatedScale(
                                    scale: index == _selectedVehicle
                                        ? 1.0
                                        : 0.98,
                                    duration: const Duration(milliseconds: 200),
                                    child: VehicleCard(
                                      vehicle: vehicles[index],
                                      isSelected: index == _selectedVehicle,
                                      onTap: () {
                                        setState(() {
                                          _selectedVehicle = index;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Order button with gradient
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade600,
                                Colors.blue.shade400,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => OrderCheckoutScreen(
                                          selectedVehicle:
                                              vehicles[_selectedVehicle],
                                          pickupAddress: _pickupAddress,
                                          deliveryAddress: _deliveryAddress,
                                          distance: _distance,
                                          duration: _duration,
                                        ),
                                    transitionsBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                          child,
                                        ) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: SlideTransition(
                                              position: Tween<Offset>(
                                                begin: const Offset(0, 0.1),
                                                end: Offset.zero,
                                              ).animate(animation),
                                              child: child,
                                            ),
                                          );
                                        },
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.shopping_bag_outlined,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Pesan Sekarang',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

