import 'package:flutter/material.dart';
// Firebase removed: using Supabase for database/auth
import 'package:ajimashudi/features/roles/ui/admin_screen.dart';
import 'package:ajimashudi/features/roles/ui/driver_screen.dart';
import 'package:ajimashudi/features/roles/ui/user_screen.dart';
import 'package:ajimashudi/core/routing/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ajimashudi/features/auth/bloc/authentication_bloc.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://uuyuwqngeviyzgdrfjqc.supabase.co',
    anonKey: 'sb_publishable_yYtSrHUr2-tfKYS4SpeGVQ_XMSwrhTQ',
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Create the AuthenticationBloc which is available above MaterialApp

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

