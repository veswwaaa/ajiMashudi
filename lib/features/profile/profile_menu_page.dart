import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileMenuPage extends StatelessWidget {
  const ProfileMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blue[700],
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(radius: 32, backgroundColor: Colors.white, child: Icon(Icons.person, size: 36, color: Colors.blue[700])),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Ahmad Rizki', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Text('ahmad.rizki@email.com', style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 2),
                        Text('+62 812-3456-7890', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _StatItem(value: '12', label: 'Total Order'),
                          _StatItem(value: '4.8', label: 'Rating'),
                          _StatItem(value: '2', label: 'Tahun'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _MenuTile(
                    icon: Icons.edit_outlined,
                    label: 'Edit Profil',
                    onTap: () => context.push('/profile/edit'),
                  ),
                  _MenuTile(
                    icon: Icons.location_on_outlined,
                    label: 'Alamat Tersimpan',
                    onTap: () => context.push('/profile/addresses'),
                  ),
                  _MenuTile(
                    icon: Icons.credit_card_outlined,
                    label: 'Metode Pembayaran',
                    onTap: () => context.push('/profile/payment'),
                  ),
                  _MenuTile(
                    icon: Icons.notifications_none,
                    label: 'Notifikasi',
                    onTap: () => context.push('/profile/notifications'),
                  ),
                  _MenuTile(
                    icon: Icons.shield_outlined,
                    label: 'Keamanan',
                    onTap: () => context.push('/profile/security'),
                  ),
                  _MenuTile(
                    icon: Icons.help_outline,
                    label: 'Bantuan',
                    onTap: () => context.push('/profile/help'),
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red[50], foregroundColor: Colors.red),
                    onPressed: () {},
                    icon: const Icon(Icons.exit_to_app_outlined),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text('Keluar'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(child: Text('LogiBox v1.0.0', style: TextStyle(color: Colors.grey[500], fontSize: 12))),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.grey[700]),
          title: Text(label),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        const Divider(height: 1),
      ],
    );
  }
}
