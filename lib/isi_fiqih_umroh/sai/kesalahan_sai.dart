import 'package:flutter/material.dart';

class HikmahKesalahanSaiScreen extends StatelessWidget {
  final bool isDark;
  const HikmahKesalahanSaiScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg       = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr  = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final hikmah = [
      'Mengajarkan usaha sebelum tawakal',
      'Mengingat perjuangan seorang ibu',
      'Melatih kesabaran dan ketekunan',
      'Menguatkan keyakinan bahwa pertolongan Allah itu nyata',
    ];

    final kesalahan = [
      'Salah menghitung jumlah putaran',
      'Tidak memulai dari Shafa',
      'Berlari sepanjang perjalanan (padahal hanya di area lampu hijau bagi laki-laki)',
      'Sibuk bercanda atau bermain HP',
    ];

    Widget bulletList(List<String> items) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 15, color: Color(0xFFE6A63C))),
                        Expanded(child: Text(item, style: TextStyle(fontSize: 15, color: textClr))),
                      ],
                    ),
                  ))
              .toList(),
        );

    return Scaffold(
      backgroundColor: bg,
      body: Column(
        children: [
          Container(
            height: 95,
            color: appBarBg,
            child: SafeArea(
              bottom: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6, left: 8),
                      child: Text(
                        '←',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: titleClr),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Hikmah & Kesalahan',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: titleClr),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hikmah dan Kesalahan dalam Sa'i",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE6A63C),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Hikmah Sa'i:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                  ),
                  const SizedBox(height: 8),
                  bulletList(hikmah),
                  const SizedBox(height: 20),
                  Text(
                    'Kesalahan yang Sering Terjadi:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                  ),
                  const SizedBox(height: 8),
                  bulletList(kesalahan),
                  const SizedBox(height: 20),
                  Text(
                    "Sa'i bukan sekadar berjalan, tetapi ibadah penuh makna dan sejarah.",
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}