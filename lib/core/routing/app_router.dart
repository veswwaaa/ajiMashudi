import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ajimashudi/features/auth/ui/login_page_screen.dart';
import 'package:ajimashudi/features/roles/ui/admin_screen.dart';
import 'package:ajimashudi/features/roles/ui/driver_screen.dart';
import 'package:ajimashudi/features/roles/ui/user_screen.dart';
import 'package:ajimashudi/features/navigation/ui/main_navigation_screen_odoy.dart';
// import 'package:ajimashudi/screens/location_screen.dart';
// import 'package:ajimashudi/screens/google_map_screen.dart';
// import 'package:ajimashudi/screens/real_time_db_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminScreen(),
    ),
    GoRoute(
      path: '/user',
      builder: (context, state) => const UserScreen(),
    ),
    GoRoute(
      path: '/driver',
      builder: (context, state) => const DriverScreen(),
    ),
    GoRoute(
      path: '/mainNavigationScreenOdoy',
      builder: (context, state) => const MainNavigationScreen(),
    ),
  ],
  

);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
