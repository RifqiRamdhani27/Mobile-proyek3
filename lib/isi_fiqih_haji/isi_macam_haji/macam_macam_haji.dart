import 'package:flutter/material.dart';

class MacamMacamHajiScreen extends StatelessWidget {
  final bool isDark;
  const MacamMacamHajiScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final List<Map<String, String>> steps = [
      {
        "title": "Haji Ifrad",
        "desc": "Melaksanakan haji saja tanpa umroh.",
      },
      {
        "title": "Haji Qiran",
        "desc": "Melaksanakan haji dan umroh dalam satu niat sekaligus.",
      },
      {
        "title": "Haji Tamattu'",
        "desc": "Melaksanakan umroh terlebih dahulu, kemudian haji dalam satu musim haji dengan dua niat terpisah.",
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
                          'Macam-Macam Haji',
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
                      "Jenis-Jenis Haji",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Dalam pelaksanaannya, haji terbagi menjadi 3 jenis:",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: textClr,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    ...steps.asMap().entries.map((entry) {
                      int i = entry.key;
                      Map<String, String> item = entry.value;
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
                      );
                    }).toList(),
                    const SizedBox(height: 12),
                    Text(
                      "Ketiga jenis ini sah, tinggal memilih sesuai kondisi dan kemampuan jamaah.",
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