import 'package:flutter/material.dart';

class DzikirHajiUmrohScreen extends StatelessWidget {
  final bool isDark;
  const DzikirHajiUmrohScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg       = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr  = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final dzikir = [
      {
        'judul': 'Niat Ihram Haji',
        'arab': 'لَبَّيْكَ اللّهُمَّ حَجًّا',
        'arti': 'Aku penuhi panggilan-Mu ya Allah untuk berhaji.',
      },
      {
        'judul': 'Niat Ihram Umroh',
        'arab': 'لَبَّيْكَ اللّهُمَّ عُمْرَةً',
        'arti': 'Aku penuhi panggilan-Mu ya Allah untuk berumroh.',
      },
      {
        'judul': 'Talbiyah',
        'arab': 'لَبَّيْكَ اللَّهُمَّ لَبَّيْكَ، لَبَّيْكَ لَا شَرِيكَ لَكَ لَبَّيْكَ، إِنَّ الْحَمْدَ وَالنِّعْمَةَ لَكَ وَالْمُلْكَ، لَا شَرِيكَ لَكَ',
        'arti': 'Aku penuhi panggilan-Mu ya Allah, aku penuhi panggilan-Mu. Tiada sekutu bagi-Mu. Sesungguhnya segala puji, nikmat, dan kerajaan adalah milik-Mu. Tiada sekutu bagi-Mu.',
      },
      {
        'judul': "Doa Saat Melihat Ka'bah",
        'arab': 'اللّهُمَّ زِدْ هَذَا الْبَيْتَ تَشْرِيفًا وَتَعْظِيمًا',
        'arti': 'Ya Allah, tambahkanlah kemuliaan dan keagungan pada rumah ini.',
      },
    ];

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
                        'Dzikir Haji & Umroh',
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
                    'Dzikir Haji & Umroh',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE6A63C), height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  ...dzikir.map((item) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['judul']!,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            alignment: Alignment.center,
                            child: Text(
                              item['arab']!,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textClr, height: 1.8),
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
                                  text: '"${item['arti']}"',
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 16),
                        ],
                      )),
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