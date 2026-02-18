import 'package:flutter/material.dart';
// import 'monitor_driver_screen.dart';
import 'data_order_screen.dart';
import 'kelola_unit_screen.dart';
import 'kelola_driver_screen.dart';
import 'keuangan_screen.dart';

class AdminMainNavigation extends StatefulWidget {
  const AdminMainNavigation({super.key});

  @override
  State<AdminMainNavigation> createState() => _AdminMainNavigationState();
}

class _AdminMainNavigationState extends State<AdminMainNavigation> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    // const MonitorDriverScreen(),
    const DataOrderScreen(),
    const KelolaUnitScreen(),
    const KelolaDriverScreen(),
    const KeuanganScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.dashboard_outlined),
          //   activeIcon: Icon(Icons.dashboard),
          //   label: 'Monitor',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined),
            activeIcon: Icon(Icons.local_shipping),
            label: 'Unit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Driver',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Keuangan',
          ),
        ],
      ),
    );
  }
}
