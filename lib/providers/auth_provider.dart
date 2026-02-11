import 'package:supabase_flutter/supabase_flutter.dart';


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
