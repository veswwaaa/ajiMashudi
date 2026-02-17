import 'package:flutter/material.dart';

class BantuanScreen extends StatefulWidget {
  const BantuanScreen({super.key});

  @override
  State<BantuanScreen> createState() => _BantuanScreenState();
}

class _BantuanScreenState extends State<BantuanScreen> {
  final List<Map<String, dynamic>> _helpCategories = [
    {
      'title': 'Tentang Pesanan',
      'icon': Icons.local_shipping_outlined,
      'color': Colors.blue,
      'items': [
        {
          'question': 'Bagaimana cara melacak pesanan saya?',
          'answer':
              'Anda dapat melacak pesanan melalui menu "Pesanan" di aplikasi. Klik pada pesanan aktif untuk melihat status real-time dan lokasi driver.'
        },
        {
          'question': 'Berapa lama waktu pengiriman?',
          'answer':
              'Waktu pengiriman bervariasi tergantung jarak dan kondisi lalu lintas. Estimasi waktu akan ditampilkan saat Anda membuat pesanan.'
        },
        {
          'question': 'Bagaimana jika barang terlambat?',
          'answer':
              'Jika barang terlambat dari estimasi, Anda dapat menghubungi driver atau customer service kami melalui fitur chat.'
        },
      ],
    },
    {
      'title': 'Pembayaran',
      'icon': Icons.payment_outlined,
      'color': Colors.green,
      'items': [
        {
          'question': 'Metode pembayaran apa saja yang tersedia?',
          'answer':
              'Kami menerima pembayaran melalui e-wallet (GoPay, OVO, DANA), transfer bank, kartu kredit/debit, dan tunai.'
        },
        {
          'question': 'Apakah pembayaran aman?',
          'answer':
              'Ya, semua transaksi dilindungi dengan enkripsi SSL dan standar keamanan PCI DSS untuk melindungi data pembayaran Anda.'
        },
        {
          'question': 'Bagaimana cara mendapatkan invoice?',
          'answer':
              'Invoice akan dikirim otomatis ke email Anda setelah pembayaran selesai. Anda juga dapat melihatnya di riwayat pesanan.'
        },
      ],
    },
    {
      'title': 'Akun & Profil',
      'icon': Icons.account_circle_outlined,
      'color': Colors.purple,
      'items': [
        {
          'question': 'Bagaimana cara mengubah data profil?',
          'answer':
              'Buka menu Profil > Edit Profil untuk mengubah nama, email, atau nomor telepon Anda.'
        },
        {
          'question': 'Lupa password, apa yang harus dilakukan?',
          'answer':
              'Klik "Lupa Password" di halaman login, masukkan email Anda, dan ikuti instruksi reset password yang dikirim ke email.'
        },
      ],
    },
    {
      'title': 'Kebijakan & Ketentuan',
      'icon': Icons.description_outlined,
      'color': Colors.orange,
      'items': [
        {
          'question': 'Bagaimana kebijakan pembatalan?',
          'answer':
              'Anda dapat membatalkan pesanan sebelum driver mengambil barang tanpa biaya. Setelah barang diambil, berlaku biaya pembatalan.'
        },
        {
          'question': 'Bagaimana jika barang rusak atau hilang?',
          'answer':
              'Segera laporkan ke customer service kami melalui chat atau telepon. Kami akan menindaklanjuti dengan asuransi pengiriman.'
        },
      ],
    },
  ];

  Widget _buildHelpCard(Map<String, dynamic> category) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: category['color'] as Color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: (category['color'] as Color).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            category['icon'] as IconData,
            color: Colors.white,
            size: 22,
          ),
        ),
        title: Text(
          category['title'],
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        children: (category['items'] as List<Map<String, String>>)
            .map((item) => _buildFAQItem(item))
            .toList(),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.shade50.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.help_outline,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item['question']!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text(
              item['answer']!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.support_agent,
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Butuh Bantuan Lebih Lanjut?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Tim customer service kami siap membantu Anda',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Membuka chat dengan CS'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  },
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('Chat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Menelepon customer service'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Telepon'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black87,
              size: 18,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Bantuan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildContactCard(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Text(
              'Pertanyaan yang Sering Diajukan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          ..._helpCategories.map((category) => _buildHelpCard(category)).toList(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}