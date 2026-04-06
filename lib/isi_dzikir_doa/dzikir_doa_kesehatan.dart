import 'package:flutter/material.dart';

class DzikirDoaKesehatanScreen extends StatelessWidget {
  final bool isDark;
  const DzikirDoaKesehatanScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg           = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr      = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final textKotakClr = isDark ? const Color(0xFF000000) : const Color(0xFFE0C070);
    final appBarBg     = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr     = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final dzikir = [
      {
        'judul': '1. Doa Memohon Kesembuhan',
        'arab': 'اللّهُمَّ رَبَّ النَّاسِ أَذْهِبِ الْبَأْسَ، اشْفِ أَنْتَ الشَّافِي، لَا شِفَاءَ إِلَّا شِفَاؤُكَ، شِفَاءً لَا يُغَادِرُ سَقَمًا',
        'arti': 'Ya Allah Tuhan manusia, hilangkanlah penyakit ini, sembuhkanlah. Engkaulah Maha Penyembuh. Tidak ada kesembuhan kecuali kesembuhan dari-Mu, kesembuhan yang tidak meninggalkan rasa sakit.',
        'sumber': '(HR. Bukhari & Muslim)',
        'catatan': 'Dibaca saat menjenguk orang sakit atau untuk diri sendiri.',
      },
      {
        'judul': '2. Doa Perlindungan dari Penyakit',
        'arab': 'اللّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْبَرَصِ، وَالْجُنُونِ، وَالْجُذَامِ، وَمِنْ سَيِّئِ الْأَسْقَامِ',
        'arti': 'Ya Allah, aku berlindung kepada-Mu dari penyakit belang, gila, kusta, dan penyakit-penyakit buruk lainnya.',
        'sumber': '(HR. Abu Dawud)',
        'catatan': null,
      },
      {
        'judul': '3. Doa Memohon Kesehatan & Keselamatan',
        'arab': 'اللّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ',
        'arti': 'Ya Allah, aku memohon ampunan dan kesehatan (keselamatan) di dunia dan akhirat.',
        'sumber': '(HR. Tirmidzi)',
        'catatan': 'Sangat dianjurkan dibaca pagi dan petang.',
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
                      child: Text('←', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: titleClr)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text("Dzikir & Do'a Kesehatan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: titleClr)),
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
                    "Dzikir & Do'a Kesehatan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE6A63C), height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  ...dzikir.map((item) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['judul']!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr)),
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
                                  text: '"${item['arti']}"\n',
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                                TextSpan(
                                  text: item['sumber']!,
                                  style: TextStyle(fontStyle: FontStyle.italic, color: textClr.withOpacity(0.7)),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          if (item['catatan'] != null) ...[
                            const SizedBox(height: 4),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF8E7),
                                borderRadius: BorderRadius.circular(8),
                                border: const Border(left: BorderSide(color: Color(0xFFE6A63C), width: 4)),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                '📌 ${item['catatan']}',
                                style: TextStyle(fontSize: 14, height: 1.57, color: textKotakClr),
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
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