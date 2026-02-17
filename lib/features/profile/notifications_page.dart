import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool push = true;
  bool email = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi')),
      body: ListView(
        children: [
          SwitchListTile(title: const Text('Push Notification'), value: push, onChanged: (v) => setState(() => push = v)),
          const Divider(height: 1),
          SwitchListTile(title: const Text('Email Notification'), value: email, onChanged: (v) => setState(() => email = v)),
          const Divider(height: 1),
          ListTile(title: const Text('Notifikasi Promo'), trailing: const Icon(Icons.chevron_right), onTap: () {}),
        ],
      ),
    );
  }
}
