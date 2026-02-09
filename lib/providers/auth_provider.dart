import 'package:supabase_flutter/supabase_flutter.dart';

Future loginUser(username, password) async {
  final supabase = Supabase.instance.client;
  // Simulate a network call
  try {
    await supabase.auth.signInWithPassword(
      email: username,
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
