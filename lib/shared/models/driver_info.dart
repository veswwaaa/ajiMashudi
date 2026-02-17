class DriverInfo {
  final String id;
  final String name;
  final String plateNumber;
  final double rating;
  final int totalRides;
  final bool isOnline;
  final String vehicleType;
  final String? photoUrl;

  DriverInfo({
    required this.id,
    required this.name,
    required this.plateNumber,
    required this.rating,
    required this.totalRides,
    required this.isOnline,
    required this.vehicleType,
    this.photoUrl,
  });
}

