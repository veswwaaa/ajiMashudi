import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:ajimashudi/screens/admin_screen.dart';
import 'package:ajimashudi/screens/driver_screen.dart';
import 'package:ajimashudi/screens/user_screen.dart';
import 'package:ajimashudi/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ajimashudi/bloc/authentication_bloc.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://uuyuwqngeviyzgdrfjqc.supabase.co',
    anonKey: 'sb_publishable_yYtSrHUr2-tfKYS4SpeGVQ_XMSwrhTQ',
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the AuthenticationBloc which is available above MaterialApp
  final AuthenticationBloc authBloc = AuthenticationBloc();

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   routerConfig: router,
    // );
    return BlocProvider<AuthenticationBloc>(
      create: (context) => authBloc,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
