import 'package:flutter/material.dart';

final List<Map<String, String>> menuItems = [
  {"title": "Keutamaan Haji",       "image": "assets/images/keutamaan_haji.png",       "route": "/keutamaan-haji"},
  {"title": "Makna Jamaah Haji",    "image": "assets/images/makna_jemaah_haji.png",    "route": "/makna-jamaah-haji"},
  {"title": "Motivasi Berhaji",     "image": "assets/images/motivasi_berhaji.png",     "route": "/motivasi-berhaji"},
  {"title": "Sabar Saat Haji",      "image": "assets/images/sabar_saat_haji.png",      "route": "/sabar-saat-haji"},
  {"title": "Ikhlas Berhaji",       "image": "assets/images/ikhlas_berhaji.png",       "route": "/ikhlas-berhaji"},
  {"title": "Teladan Rasulullah",   "image": "assets/images/teladan_rasulullah.png",   "route": "/teladan-rasulullah"},
  {"title": "Jaga Haji agar Mabrur","image": "assets/images/jaga_haji_agar_mabrur.png","route": "/jaga-haji-mabrur"},
];

class PersiapanHajiScreen extends StatelessWidget {
  final bool isDark;
  const PersiapanHajiScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg       = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);
    final cardBg   = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
    final textClr  = isDark ? const Color(0xFFE0C070) : const Color(0xFF000000);
    final shadowClr= isDark ? const Color(0xFFD8AB17) : const Color(0xFF000000);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    return Scaffold(
      backgroundColor: bg,
      body: Column(
        children: [
          // ── AppBar ──────────────────────────────────────────────────────────
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
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Persiapan Haji',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: titleClr,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── List Menu ────────────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, item['route']!);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: shadowClr.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          item['image']!,
                          width: 40,
                          height: 40,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.image,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item['title']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textClr,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}