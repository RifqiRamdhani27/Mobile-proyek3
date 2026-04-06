import 'package:flutter/material.dart';

class KeutamaanAirZamzamScreen extends StatelessWidget {
  final bool isDark;
  const KeutamaanAirZamzamScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg       = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr  = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final keutamaan = [
      'Air yang penuh keberkahan',
      'Bisa diminum dengan niat kebaikan',
      'Mengingatkan pada tawakal Siti Hajar',
    ];

    final adab = [
      'Menghadap kiblat',
      'Membaca basmalah',
      'Minum tiga kali teguk',
      'Berdoa setelah minum',
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
                        'Keutamaan Air Zamzam',
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
                    'Keutamaan dan Adab Minum Air Zamzam',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE6A63C),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E7),
                      borderRadius: BorderRadius.circular(8),
                      border: const Border(
                        left: BorderSide(color: Color(0xFFE6A63C), width: 4),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Column(
                      children: [
                        Text(
                          '"Air Zamzam sesuai dengan niat orang yang meminumnya."',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF1A1A1A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(HR. Ibnu Majah)',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF888888),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Keutamaannya:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                  ),
                  const SizedBox(height: 8),
                  bulletList(keutamaan),
                  const SizedBox(height: 20),
                  Text(
                    'Adab saat minum Air Zamzam:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                  ),
                  const SizedBox(height: 8),
                  bulletList(adab),
                  const SizedBox(height: 20),
                  Text(
                    'Zamzam bukan sekadar air, tetapi simbol keimanan dan pertolongan Allah.',
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