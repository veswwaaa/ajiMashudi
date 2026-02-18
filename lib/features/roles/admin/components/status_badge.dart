import 'package:flutter/material.dart';

enum DriverStatus { sibuk, online, offline }

class StatusBadge extends StatelessWidget {
  final DriverStatus status;
  final double fontSize;
  final EdgeInsets padding;

  const StatusBadge({
    super.key,
    required this.status,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  });

  Color get _backgroundColor {
    switch (status) {
      case DriverStatus.sibuk:
        return Colors.orange.shade400;
      case DriverStatus.online:
        return Colors.green.shade400;
      case DriverStatus.offline:
        return Colors.grey.shade400;
    }
  }

  String get _label {
    switch (status) {
      case DriverStatus.sibuk:
        return 'Sibuk';
      case DriverStatus.online:
        return 'Online';
      case DriverStatus.offline:
        return 'Offline';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _label,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
