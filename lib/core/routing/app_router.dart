import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ajimashudi/features/auth/ui/login_page_screen.dart';
import 'package:ajimashudi/features/roles/ui/admin_screen.dart';
import 'package:ajimashudi/features/roles/ui/driver_screen.dart';
import 'package:ajimashudi/features/roles/ui/user_screen.dart';
import 'package:ajimashudi/features/navigation/ui/main_navigation_screen_odoy.dart';
import 'package:ajimashudi/features/auth/bloc/authentication_bloc.dart';
import 'package:ajimashudi/features/profile/profile_menu_page.dart';
import 'package:ajimashudi/features/profile/edit_profile_page.dart' as edit;
import 'package:ajimashudi/features/profile/addresses_page.dart';
import 'package:ajimashudi/features/profile/payment_methods_page.dart';
import 'package:ajimashudi/features/profile/security_page.dart';
import 'package:ajimashudi/features/profile/help_page.dart';
import 'package:ajimashudi/features/profile/ui/profil_screen.dart';

// import 'package:ajimashudi/screens/location_screen.dart';
// import 'package:ajimashudi/screens/google_map_screen.dart';
// import 'package:ajimashudi/screens/real_time_db_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
final AuthenticationBloc authBloc = AuthenticationBloc();

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/admin', builder: (context, state) => const AdminScreen()),
    GoRoute(path: '/user', builder: (context, state) => const UserScreen()),
    GoRoute(path: '/driver', builder: (context, state) => const DriverScreen()),
    GoRoute(
      path: '/mainNavigationScreenOdoy',
      builder: (context, state) => const MainNavigationScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileMenuPage(),
      routes: [
        GoRoute(path: 'edit', builder: (context, state) => edit.EditProfilePage()),
        GoRoute(path: 'addresses', builder: (context, state) => const AddressesPage()),
        GoRoute(path: 'payment', builder: (context, state) => const MetodePembayaranScreen()),
        GoRoute(
          path: 'notifications',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Notifikasi')),
            body: const Center(child: Text('Halaman Notifikasi')),
          ),
        ),
        GoRoute(path: 'view', builder: (context, state) => const ProfilScreen()),
        GoRoute(path: 'security', builder: (context, state) => const KeamananScreen()),
        GoRoute(path: 'help', builder: (context, state) => const BantuanScreen()),
      ],
    ),
  ],
  refreshListenable: StreamToListenable([authBloc.stream]),
  //The top-level callback allows the app to redirect to a new location.
  redirect: (context, state) {
    print(authBloc.state);
    final isAuthenticated = authBloc.state is Authenticated;
    final isUnAuthenticated = authBloc.state is Unauthenticated;

    // Redirect to the login page if the user is not authenticated.
    if (isUnAuthenticated && !(state.matchedLocation == '/')) {
      return '/';
    }
    // If the user is authenticated, only redirect from the login page
    // to the main navigation. Allow navigation to other routes (e.g. /profile/*).
    else if (isAuthenticated && state.matchedLocation == '/') {
      return '/mainNavigationScreenOdoy';
    }
    return null;
  },
);

// class GoRouterRefreshStream extends ChangeNotifier {
//   GoRouterRefreshStream(Stream<dynamic> stream) {
//     notifyListeners();
//     _subscription = stream.asBroadcastStream().listen(
//           (dynamic _) => notifyListeners(),
//         );
//   }

//   late final StreamSubscription<dynamic> _subscription;

//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
// }

// for convert stream to listenable
class StreamToListenable extends ChangeNotifier {
  late final List<StreamSubscription> subscriptions;

  StreamToListenable(List<Stream> streams) {
    subscriptions = [];
    for (var e in streams) {
      var s = e.asBroadcastStream().listen(_tt);
      subscriptions.add(s);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (var e in subscriptions) {
      e.cancel();
    }
    super.dispose();
  }

  void _tt(event) => notifyListeners();
}
