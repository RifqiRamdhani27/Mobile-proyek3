import 'package:flutter/material.dart';
import 'thowaf/penjelasan_thowaf.dart';
import 'thowaf/tata_cara_thowaf.dart';
import 'thowaf/kewajiban_saat_thowaf.dart';
import 'thowaf/larangan_saat_thowaf.dart';
import 'thowaf/sunnah_saat_thowaf.dart';
import 'thowaf/macam_macam_thowaf.dart';

final List<Map<String, String>> thowafMenuItems = [
  {"title": "Penjelasan Thowaf",     "image": "assets/images/thowaf.png",        "route": "/thowaf/penjelasan_thowaf"},
  {"title": "Tata Cara Thowaf",      "image": "assets/images/niat_umroh.png",    "route": "/thowaf/tata_cara_thowaf"},
  {"title": "Kewajiban Saat Thowaf", "image": "assets/images/sunnah_ihram.png",  "route": "/thowaf/kewajiban_saat_thowaf"},
  {"title": "Larangan Saat Thowaf",  "image": "assets/images/larangan.png",      "route": "/thowaf/larangan_saat_thowaf"},
  {"title": "Sunnah Saat Thowaf",    "image": "assets/images/sujud.png",         "route": "/thowaf/sunnah_saat_thowaf"},
  {"title": "Macam Macam Thowaf",    "image": "assets/images/macam_thowaf.png",  "route": "/thowaf/macam_macam_thowaf"},
];

class ThowafScreen extends StatelessWidget {
  final bool isDark;
  const ThowafScreen({super.key, this.isDark = false});

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
                      'Thowaf',
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
              itemCount: thowafMenuItems.length,
              itemBuilder: (context, index) {
                final item = thowafMenuItems[index];
                return GestureDetector(
                  onTap: () {
                    final route = item['route']!;
                    final screenMap = <String, Widget>{
                      '/thowaf/penjelasan_thowaf':     PenjelasanThowafScreen(isDark: isDark),
                      '/thowaf/tata_cara_thowaf':      TataCaraThowafScreen(isDark: isDark),
                      '/thowaf/kewajiban_saat_thowaf': KewajibanSaatThowafScreen(isDark: isDark),
                      '/thowaf/larangan_saat_thowaf':  LaranganSaatThowafScreen(isDark: isDark),
                      '/thowaf/sunnah_saat_thowaf':    SunnahSaatThowafScreen(isDark: isDark),
                      '/thowaf/macam_macam_thowaf':    MacamMacamThowafScreen(isDark: isDark),
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