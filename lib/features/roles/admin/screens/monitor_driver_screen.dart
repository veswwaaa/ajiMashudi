import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ajimashudi/shared/widgets/google_map_widget.dart';
import 'package:ajimashudi/shared/models/location_marker.dart';
import '../components/driver_card.dart';
import '../components/status_badge.dart';

class MonitorDriverScreen extends StatefulWidget {
  const MonitorDriverScreen({super.key});

  @override
  State<MonitorDriverScreen> createState() => _MonitorDriverScreenState();
}

class _MonitorDriverScreenState extends State<MonitorDriverScreen> {
  // Data dummy untuk driver
  final List<Map<String, dynamic>> _drivers = [
    {
      'name': 'Budi Santoso',
      'vehicleNumber': 'B 1234 XYZ',
      'status': DriverStatus.sibuk,
      'latitude': '-6.2088',
      'longitude': '106.8456',
      'position': const LatLng(-6.2088, 106.8456),
    },
    {
      'name': 'Dedi Kusuma',
      'vehicleNumber': 'B 5678 ABC',
      'status': DriverStatus.online,
      'latitude': '-6.2108',
      'longitude': '106.8500',
      'position': const LatLng(-6.2108, 106.8500),
    },
    {
      'name': 'Eko Prasetyo',
      'vehicleNumber': 'B 9012 DEF',
      'status': DriverStatus.online,
      'latitude': '-6.1950',
      'longitude': '106.8300',
      'position': const LatLng(-6.1950, 106.8300),
    },
    {
      'name': 'Fajar Nugroho',
      'vehicleNumber': 'B 3456 GHI',
      'status': DriverStatus.offline,
      'latitude': '-6.1900',
      'longitude': '106.8200',
      'position': const LatLng(-6.1900, 106.8200),
    },
  ];

  late List<LocationMarker> _markers;

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    _markers = _drivers
        .where((driver) => driver['status'] != DriverStatus.offline)
        .map(
          (driver) => LocationMarker(
            id: driver['name'],
            position: driver['position'],
            title: driver['name'],
            description: driver['vehicleNumber'],
            type: MarkerType.vehicle,
          ),
        )
        .toList();
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
              'Monitor Driver',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Pantau lokasi driver secara realtime',
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
            // Google Maps Section
            Container(
              height: 300,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMapWidget(
                  markers: _markers,
                  initialPosition: const LatLng(-6.2088, 106.8456),
                  onMarkerTap: (marker) {
                    // Handle marker tap
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Driver: ${marker.title}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Map View Mode Toggle (Muck)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Map View (Muck)',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Daftar Driver Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daftar Driver',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${_drivers.length} Driver',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Driver Cards List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _drivers.length,
              itemBuilder: (context, index) {
                final driver = _drivers[index];
                return DriverCard(
                  name: driver['name'],
                  vehicleNumber: driver['vehicleNumber'],
                  status: driver['status'],
                  latitude: driver['latitude'],
                  longitude: driver['longitude'],
                  onTap: () {
                    // Handle driver card tap
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Detail driver: ${driver['name']}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
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
