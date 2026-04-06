import 'package:flutter/material.dart';

class UrutanUmumHajiScreen extends StatelessWidget {
  final bool isDark;
  const UrutanUmumHajiScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final List<String> steps = [
      "Ihram dari miqot",
      "Tawaf Qudum & Sa'i",
      "Mabit di Mina",
      "Wukuf di Arafah (9 Dzulhijah)",
      "Mabit di Muzdalifah",
      "Melempar Jumrah",
      "Tahallul (cukur rambut)",
      "Jumrah Aqabah",
      "Tawaf Wada' (tawaf perpisahan)",
      "Kembali ke tanah air",
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
                          'Urutan Umum Perjalanan Haji',
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
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/images/rute_ibadah_haji.png",
                        width: double.infinity,
                        height: 320,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 320,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, size: 50),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "Rute Ibadah Haji (Tamattu')",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE6A63C),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // List Steps
                    ...steps.asMap().entries.map((entry) {
                      int i = entry.key;
                      String step = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 28,
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
                                step,
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.6,
                                  color: textClr,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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