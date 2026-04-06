import 'package:flutter/material.dart';

class PenjelasanTahallulScreen extends StatelessWidget {
  final bool isDark;
  const PenjelasanTahallulScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg       = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr  = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final ketentuan = [
      'Laki-laki lebih utama menggundul rambut (halq).',
      'Boleh juga memendekkan rambut (taqsir).',
      'Perempuan cukup memotong sedikit ujung rambutnya.',
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
                        'Penjelasan Tahallul',
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
                    'Tahallul',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE6A63C), height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tahallul adalah mencukur atau memotong rambut sebagai tanda selesainya rangkaian ibadah umroh atau sebagian rangkaian haji.',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Tahallul dilakukan setelah selesai sa'i dalam umroh. Dengan tahallul, jamaah keluar dari keadaan ihram dan diperbolehkan kembali melakukan hal-hal yang sebelumnya dilarang saat ihram.",
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Allah berfirman dalam QS. Al-Fath ayat 27:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Text(
                      'لَتَدْخُلُنَّ الْمَسْجِدَ الْحَرَامَ إِن شَاءَ اللَّهُ آمِنِينَ مُحَلِّقِينَ رُءُوسَكُمْ وَمُقَصِّرِينَ لَا تَخَافُونَ',
                      style: TextStyle(fontSize: 20, height: 2.0, color: textClr),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E7),
                      borderRadius: BorderRadius.circular(8),
                      border: const Border(left: BorderSide(color: Color(0xFFE6A63C), width: 4)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '"Sungguh, kamu pasti akan memasuki Masjidil Haram, insya Allah dalam keadaan aman, dengan mencukur rambut kepala dan memendekkannya, sedang kamu tidak merasa takut."',
                          style: TextStyle(fontSize: 15, height: 1.6, fontStyle: FontStyle.italic, color: Color(0xFF1A1A1A)),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(QS. Al-Fath: 27)',
                          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Color(0xFF888888)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ayat ini menjadi dalil bahwa mencukur atau memotong rambut adalah bagian dari syariat dalam ibadah haji dan umroh.',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ketentuan tahallul:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                  ),
                  const SizedBox(height: 8),
                  ...ketentuan.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ', style: TextStyle(fontSize: 15, color: Color(0xFFE6A63C))),
                            Expanded(child: Text(item, style: TextStyle(fontSize: 15, color: textClr))),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  Text(
                    'Tahallul menandakan penyempurnaan ibadah dan ketaatan kepada Allah.',
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