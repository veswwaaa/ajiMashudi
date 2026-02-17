import 'package:flutter/material.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alamat Tersimpan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _AddressCard(title: 'Rumah', subtitle: 'Jl. Mawar No.12, Jakarta'),
          const SizedBox(height: 12),
          _AddressCard(title: 'Kantor', subtitle: 'Jl. Sudirman No.45, Jakarta'),
          const SizedBox(height: 24),
          ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Tambah Alamat')),
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const _AddressCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.home_outlined),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
      ),
    );
  }
}
