import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMarker {
  final String id;
  final LatLng position;
  final String title;
  final String description;
  final MarkerType type; // USER_LOCATION, PICKUP, DELIVERY, VEHICLE

  LocationMarker({
    required this.id,
    required this.position,
    required this.title,
    required this.description,
    required this.type,
  });
}

enum MarkerType {
  userLocation,
  pickupPoint,
  deliveryPoint,
  vehicle,
}

extension MarkerTypeExtension on MarkerType {
  IconData get icon {
    switch (this) {
      case MarkerType.userLocation:
        return Icons.location_on;
      case MarkerType.pickupPoint:
        return Icons.store_mall_directory;
      case MarkerType.deliveryPoint:
        return Icons.home;
      case MarkerType.vehicle:
        return Icons.local_shipping;
    }
  }

  Color get color {
    switch (this) {
      case MarkerType.userLocation:
        return Colors.blue;
      case MarkerType.pickupPoint:
        return Colors.purple;
      case MarkerType.deliveryPoint:
        return Colors.red;
      case MarkerType.vehicle:
        return const Color(0xFFFF9800);
    }
  }

  String get label {
    switch (this) {
      case MarkerType.userLocation:
        return 'Lokasi Anda';
      case MarkerType.pickupPoint:
        return 'Titik Jemput';
      case MarkerType.deliveryPoint:
        return 'Titik Pengiriman';
      case MarkerType.vehicle:
        return 'Kendaraan';
    }
  }
}

