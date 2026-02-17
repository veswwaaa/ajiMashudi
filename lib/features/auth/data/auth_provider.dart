import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

//ini fungsi untuk login
Future loginUser(email, password) async {
  final supabase = Supabase.instance.client;
  try {
    if (email.isEmpty) {
      // _showSnackBar('Email tidak boleh kosong', isError: true);
      // return;
      throw AuthException('Email tidak boleh kosong');
    }

    if (!email.contains('@')) {
      // _showSnackBar('Format email tidak valid', isError: true);
      // return;
      throw AuthException('Format email tidak valid');
    }

    if (password.isEmpty) {
      // _showSnackBar('Password tidak boleh kosong', isError: true);
      // return;
      throw AuthException('Password tidak boleh kosong');
    }
    //kode untuk login pake password & username
    await supabase.auth.signInWithPassword(email: email, password: password);
    final data = await supabase.auth.getUserIdentities();

    //kode ngambil data si user
    final dbData = await supabase
        .from('users')
        .select()
        .eq('uid', data.first.id); // equals filter

    //ni return ny
    return {
      'success': true,
      'name': dbData.first['display_name'],
      'role': dbData.first['role'],
      'uid': data.first.id,
    };
  } on AuthException catch (error) {
    // Ambil statusCode di sini
    String? status = error.statusCode;
    String? code = error.code; // 'invalid_credentials'
    String message = error.message; // 'Invalid login credentials'

    // print('Status Code: $status');
    // print('Error Code: $code');
    print(error);
    if (error.message == 'Invalid login credentials') {
      message = 'Login gagal. Email atau password salah';
    }
    if (error.message == 'Email not confirmed') {
      message =
          'Email berlum terverifikasi. Silahkan cek email anda untuk verifikasi akun.';
    }
    return {'success': false, 'error': message};
  } catch (e) {
    print('Error tidak terduga: $e');
  }
}

Future LoginOauthUser() async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;
    final supabase = Supabase.instance.client;
    unawaited(
      googleSignIn.initialize(
        clientId:
            "1046944949705-7gmhp08qnkh38mbis4fk9uauc602lnrg.apps.googleusercontent.com",
        serverClientId:
            "1046944949705-og0jttfujlh646rdfg3vek0nk8b7r2ag.apps.googleusercontent.com",
      ),
    );

    final googleUser = await googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final idToken = googleAuth.idToken;
    final response = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken!,
    );

    var userData = await supabase
        .from('users')
        .select()
        .eq('uid', response.user!.id)
        .maybeSingle();

    // kepin: ey no ku pake b.inggris aj ya ngomment nya biar enak
    // if user data does not exist, create a new record
    if (userData == null) {
      await supabase.from('users').insert({
        'uid': response.user!.id,
        'display_name': response.user!.userMetadata!['full_name'] ?? 'No Name',
      });
      userData = await supabase
          .from('users')
          .select()
          .eq('uid', response.user!.id)
          .maybeSingle();
    }

    return {
      'success': true,
      'name': userData!['display_name'],
      'role': userData['role'],
      'uid': userData['uid'],
    };
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

Future signInUser({username, email, password}) async {
  final supabase = Supabase.instance.client;
  try {
    if (username.isEmpty) {
      // _showSnackBar('username tidak boleh kosong', isError: true);
      // return;
      throw ("Username tidak boleh kosong");
    }

    if (username.length < 3) {
      // _showSnackBar('username minimal 3 karakter', isError: true);
      // return;
      throw ("Username minimal 3 karakter");
    }

    if (email.isEmpty) {
      // _showSnackBar('Email tidak boleh kosong', isError: true);
      // return;
      throw ("Email tidak boleh kosong");
    }

    if (!email.contains('@') || !email.contains('.')) {
      // _showSnackBar('Format email tidak valid', isError: true);
      // return;
      throw ("Format email tidak valid");
    }

    if (password.isEmpty) {
      // _showSnackBar('Password tidak boleh kosong', isError: true);
      // return;
      throw ("Password tidak boleh kosong");
    }

    if (password.length < 6) {
      // _showSnackBar('Password minimal 6 karakter', isError: true);
      // return;
      throw ("Password minimal 6 karakter");
    }
    //gitula
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: 'ajimashudicallback://login-callback',
    );
    final Session? session = res.session;

    final User? user = res.user;
    await supabase.from('users').insert({
      'uid': user!.id,
      'display_name': username,
    });
    //capek cuk komenin satu" anj
    // print(session!);
    // print(user!);
    return {
      'success': true,
      // 'name' : dbData.first['display_name'],
      // 'role' : dbData.first['role'],
      // 'uid' : data.first.id
    };
  } on PostgrestException catch (error) {
    String message = error.message; // 'Invalid login credentials'
    // print('Postgrest Error: $message');

    if (message ==
        "insert or update on table \"users\" violates foreign key constraint \"users_uid_fkey\"") {
      message = 'Email sudah terdaftar. Silahkan gunakan email lain';
    }
    return {'success': false, 'error': message};
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

Future logOutUser() async {
  final supabase = Supabase.instance.client;
  try {
    await supabase.auth.signOut();
    return {'success': true};
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

Future checkSession() async {
  final supabase = Supabase.instance.client;
  final session = supabase.auth.currentSession;
  if (session != null) {
    final data = await supabase.auth.getUserIdentities();
    final dbData = await supabase
        .from('users')
        .select()
        .eq('uid', data.first.id)
        .maybeSingle();

    return {
      'isAuthenticated': true,
      'name': dbData!['display_name'],
      'role': dbData['role'],
      'uid': data.first.id,
    };
  } else {
    return {'isAuthenticated': false};
  }
}
