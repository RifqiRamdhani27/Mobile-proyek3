import 'package:flutter/material.dart';
import 'ihram_miqot/penjelasan_ihram_miqot.dart';
import 'ihram_miqot/niat_umroh.dart';
import 'ihram_miqot/sunnah_ihram.dart';
import 'ihram_miqot/larangan_saat_ihram.dart';

final List<Map<String, String>> menuItems = [
  {"title": "Penjelasan Ihram di Miqot", "image": "assets/images/ihram_di_miqat.png", "route": "/ihram_miqot/penjelasan_ihram_miqot"},
  {"title": "Niat Umroh",                "image": "assets/images/niat_umroh.png",      "route": "/ihram_miqot/niat_umroh"},
  {"title": "Sunnah Saat Ihram",         "image": "assets/images/sunnah_ihram.png",    "route": "/ihram_miqot/sunnah_ihram"},
  {"title": "Larangan Saat Ihram",       "image": "assets/images/larangan.png",        "route": "/ihram_miqot/larangan_saat_ihram"},
];

class IhramMiqotScreen extends StatelessWidget {
  final bool isDark;
  const IhramMiqotScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg        = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);
    final cardBg    = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
    final textClr   = isDark ? const Color(0xFFE0C070) : const Color(0xFF000000);
    final shadowClr = isDark ? const Color(0xFFD8AB17) : const Color(0xFF000000);
    final appBarBg  = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr  = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

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
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Ihram di Miqot',
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return GestureDetector(
                  onTap: () {
                    final route = item['route']!;
                    final screenMap = <String, Widget>{
                      '/ihram_miqot/penjelasan_ihram_miqot':    PenjelasanIhramMiqotScreen(isDark: isDark),
                      '/ihram_miqot/niat_umroh':             NiatUmrohScreen(isDark: isDark),
                      '/ihram_miqot/sunnah_ihram':           SunnahIhramScreen(isDark: isDark),
                      '/ihram_miqot/larangan_saat_ihram':    LaranganSaatIhramScreen(isDark: isDark),
                    };
                    final screen = screenMap[route];
                    if (screen != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
                    }
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