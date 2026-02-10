import 'package:supabase_flutter/supabase_flutter.dart';

Future loginUser(email, password) async {
  final supabase = Supabase.instance.client;
  // Simulate a network call
  try {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final data = await supabase.auth.getUserIdentities();
    final dbData = await supabase
  .from('users')
  .select()
  .eq('uid', data.first.id); // equals filter
    return {
      'success' : true,
      'name' : dbData.first['display_name'],
      'role' : dbData.first['role'],
      'uid' : data.first.id
    };
  } catch (e) {
    return {
      'success' : false,
      'error': e.toString()
    };
  }
}

Future signInUser({username, email, password}) async {
  final supabase = Supabase.instance.client;
  try{
  final AuthResponse res = await supabase.auth.signUp(
  email: email,
  password: password,
  );
  final Session? session = res.session;

  final User? user = res.user;
  await supabase
    .from('users')
    .insert({'uid': user!.id, 'display_name': username});
    
  print(session!);
  print(user!);
  return {
      'success' : true,
      // 'name' : dbData.first['display_name'],
      // 'role' : dbData.first['role'],
      // 'uid' : data.first.id
    };
  } catch (e) {
    return {
      'success' : false,
      'error': e.toString()
    };
  }
}

