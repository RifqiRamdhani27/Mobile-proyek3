import 'package:flutter/material.dart';

class PerbedaanJenisHajiScreen extends StatelessWidget {
  final bool isDark;
  const PerbedaanJenisHajiScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final List<Map<String, dynamic>> steps = [
      {
        "title": "Haji Ifrad",
        "points": ["Niat haji saja", "Tidak wajib dam"],
      },
      {
        "title": "Haji Qiran",
        "points": ["Niat haji dan umroh sekaligus", "Wajib membayar dam"],
      },
      {
        "title": "Haji Tamattu'",
        "points": ["Umroh dulu, lalu haji", "Wajib membayar dam"],
      },
    ];

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: bg,
        body: Column(
          children: [
            // AppBar
            Container(
              height: 95,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: appBarBg,
              child: SafeArea(
                bottom: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
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
                          'Perbedaan Masing-masing Haji',
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
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Perbandingan Jenis Haji",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...steps.asMap().entries.map((entry) {
                      int i = entry.key;
                      Map<String, dynamic> item = entry.value;
                      List<String> points = item['points'];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24,
                              child: Text(
                                "${i + 1}.",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE6A63C),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: textClr,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  ...points.map((point) => Padding(
                                        padding: const EdgeInsets.only(bottom: 2),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("• ", style: TextStyle(color: textClr, fontSize: 14)),
                                            Expanded(
                                              child: Text(
                                                point,
                                                style: TextStyle(
                                                  color: textClr,
                                                  fontSize: 14,
                                                  height: 1.4,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 12),
                    Text(
                      "Sebagian besar jamaah Indonesia biasanya melaksanakan haji tamattu'.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: textClr,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}