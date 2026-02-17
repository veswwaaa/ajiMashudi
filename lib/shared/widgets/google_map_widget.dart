import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ajimashudi/shared/models/location_marker.dart';

class GoogleMapWidget extends StatefulWidget {
  final List<LocationMarker> markers;
  final LatLng initialPosition;
  final Function(LocationMarker)? onMarkerTap;

  const GoogleMapWidget({
    required this.markers,
    required this.initialPosition,
    this.onMarkerTap,
    super.key,
  });

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController mapController;
  late Set<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    _markers = widget.markers.map((marker) {
      return Marker(
        markerId: MarkerId(marker.id),
        position: marker.position,
        infoWindow: InfoWindow(
          title: marker.title,
          snippet: marker.description,
        ),
        onTap: () {
          widget.onMarkerTap?.call(marker);
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(
          _getMarkerHue(marker.type),
        ),
      );
    }).toSet();
  }

  double _getMarkerHue(MarkerType type) {
    switch (type) {
      case MarkerType.userLocation:
        return BitmapDescriptor.hueBlue;
      case MarkerType.pickupPoint:
        return BitmapDescriptor.hueViolet;
      case MarkerType.deliveryPoint:
        return BitmapDescriptor.hueRed;
      case MarkerType.vehicle:
        return BitmapDescriptor.hueOrange;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _moveCameraToFitMarkers();
  }

  void _moveCameraToFitMarkers() {
    if (widget.markers.isEmpty) return;

    // Hitung bounds dari semua markers
    double minLat = widget.markers.first.position.latitude;
    double maxLat = widget.markers.first.position.latitude;
    double minLng = widget.markers.first.position.longitude;
    double maxLng = widget.markers.first.position.longitude;

    for (var marker in widget.markers) {
      minLat = (marker.position.latitude < minLat)
          ? marker.position.latitude
          : minLat;
      maxLat = (marker.position.latitude > maxLat)
          ? marker.position.latitude
          : maxLat;
      minLng = (marker.position.longitude < minLng)
          ? marker.position.longitude
          : minLng;
      maxLng = (marker.position.longitude > maxLng)
          ? marker.position.longitude
          : maxLng;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: widget.initialPosition,
        zoom: 15,
      ),
      markers: _markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      mapToolbarEnabled: true,
    );
  }
}

