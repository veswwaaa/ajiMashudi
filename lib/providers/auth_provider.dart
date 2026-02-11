import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

//ini fungsi untuk login
Future loginUser(email, password) async {
  final supabase = Supabase.instance.client;
  try {
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
  } catch (e) {
    return {'success': false, 'error': e.toString()};
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
    final googleAuth = await googleUser!.authentication;
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
          'display_name':
              response.user!.userMetadata!['full_name'] ?? 'No Name',
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
      'role': userData!['role'],
      'uid': userData!['uid'],
    };
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

Future signInUser({username, email, password}) async {
  final supabase = Supabase.instance.client;
  try {
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
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
