import 'package:flutter/material.dart';

class WajibHajiScreen extends StatelessWidget {
  final bool isDark;
  const WajibHajiScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final List<Map<String, String?>> steps = [
      {"title": "Ihram dari miqot", "desc": null},
      {"title": "Mabit (bermalam) di Muzdalifah", "desc": null},
      {"title": "Mabit di Mina", "desc": null},
      {"title": "Melontar jumrah", "desc": null},
      {"title": "Thawaf Wada'", "desc": null},
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
              color: appBarBg,
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            color: titleClr
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          'Wajib Haji',
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold, 
                            color: titleClr
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
                      "Wajib Haji",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Wajib haji adalah amalan yang harus dilakukan. Jika ditinggalkan, hajinya tetap sah tetapi wajib membayar dam (denda).",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: textClr,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Wajib haji antara lain:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: textClr,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...steps.asMap().entries.map((entry) {
                      int i = entry.key;
                      var item = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
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
                              child: Text(
                                item['title']!,
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.46,
                                  color: textClr,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 12),
                    Text(
                      "Berbeda dengan rukun, wajib haji bisa diganti dengan dam jika terlewat.",
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