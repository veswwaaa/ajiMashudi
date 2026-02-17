import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ajimashudi/features/auth/ui/login_page_screen.dart';
import 'package:ajimashudi/features/roles/ui/admin_screen.dart';
import 'package:ajimashudi/features/roles/ui/driver_screen.dart';
import 'package:ajimashudi/features/roles/ui/user_screen.dart';
import 'package:ajimashudi/features/navigation/ui/main_navigation_screen_odoy.dart';
import 'package:ajimashudi/features/auth/bloc/authentication_bloc.dart';

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
  ],
  refreshListenable: StreamToListenable([authBloc.stream]),
  //The top-level callback allows the app to redirect to a new location.
  redirect: (context, state) {
    print(authBloc.state);
    final isAuthenticated = authBloc.state is Authenticated;
    final isUnAuthenticated = authBloc.state is Unauthenticated;

    // Redirect to the login page if the user is not authenticated, and if authenticated, do not show the login page
    if (isUnAuthenticated &&
        !(state.matchedLocation == '/')) {
      return '/';
    }
    // Redirect to the home page if the user is authenticated
    else if (isAuthenticated) {
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
