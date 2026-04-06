import 'package:flutter/material.dart';

class NiatUmrohScreen extends StatelessWidget {
  final bool isDark;
  const NiatUmrohScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg       = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr  = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

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
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: titleClr,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Niat Umroh',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: titleClr,
                        ),
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
                    'Niat Umroh',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE6A63C),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Niat dilakukan ketika sudah sampai di miqot dan siap memulai ibadah.',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lafadz niat umroh:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Text(
                      'لَبَّيْكَ عُمْرَةً',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textClr,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      text: 'Artinya:\n',
                      style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                      children: [
                        TextSpan(
                          text: '"Aku penuhi panggilan-Mu untuk melaksanakan umroh."',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Setelah niat, disunnahkan membaca talbiyah:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Text(
                      'لَبَّيْكَ اللَّهُمَّ لَبَّيْكَ...',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textClr,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Talbiyah dibaca dengan penuh penghayatan sebagai tanda memenuhi panggilan Allah.',
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