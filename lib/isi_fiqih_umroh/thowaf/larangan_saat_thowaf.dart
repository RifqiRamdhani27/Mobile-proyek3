import 'package:flutter/material.dart';

class LaranganSaatThowafScreen extends StatelessWidget {
  final bool isDark;
  const LaranganSaatThowafScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg       = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr  = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final items = [
      {
        'title': 'Bertengkar atau berkata kasar',
        'desc': 'Allah berfirman dalam QS. Al-Baqarah ayat 197:\n"Tidak boleh rafats (berkata kotor), berbuat fasik, dan berbantah-bantahan dalam haji."',
      },
      {
        'title': 'Menyakiti atau mendorong jamaah lain',
        'desc': 'Tidak boleh berebut hingga melukai orang lain.',
      },
      {
        'title': 'Melakukan perbuatan maksiat',
        'desc': 'Seperti berkata kotor, berteriak-teriak tanpa alasan, atau bercanda berlebihan.',
      },
      {
        'title': 'Keluar dari area thowaf tanpa alasan syar\'i',
        'desc': 'Sehingga putaran menjadi terputus.',
      },
      {
        'title': 'Tidak menjaga kekhusyukan',
        'desc': 'Terlalu sibuk foto, bercanda, atau berbicara hal duniawi berlebihan.',
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
                        'Larangan Saat Thowaf',
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
                    'Larangan Saat Thowaf',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE6A63C),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Agar ibadah tetap sah dan bernilai, ada beberapa hal yang harus dihindari saat thowaf:',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  ...items.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE6A63C),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: textClr,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item['desc']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.57,
                                      color: textClr.withOpacity(0.85),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  Text(
                    'Thowaf adalah ibadah yang agung, maka harus dilakukan dengan tenang, tertib, dan penuh rasa hormat kepada Allah.',
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