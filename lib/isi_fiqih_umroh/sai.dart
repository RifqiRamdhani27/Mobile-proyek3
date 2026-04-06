import 'package:flutter/material.dart';
import 'sai/sejarah_sai.dart';
import 'sai/penjelasan_sai.dart';
import 'sai/sunnah_sai.dart';
import 'sai/kesalahan_sai.dart';

final List<Map<String, String>> saiMenuItems = [
  {"title": "Sejarah Sa'i",                  "image": "assets/images/sejarah_sai.png",    "route": "/sai/sejarah_sai"},
  {"title": "Penjelasan Sa'i",               "image": "assets/images/penjelasan_sai.png", "route": "/sai/penjelasan_sai"},
  {"title": "Tata Cara & Sunnah Sa'i",       "image": "assets/images/sunnah_sai.png",     "route": "/sai/sunnah_sai"},
  {"title": "Hikmah & Kesalahan dalam Sa'i", "image": "assets/images/kesalahan_sai.png",  "route": "/sai/kesalahan_sai"},
];

class SaiScreen extends StatelessWidget {
  final bool isDark;
  const SaiScreen({super.key, this.isDark = false});

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
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: titleClr),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Sa'i",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: titleClr),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: saiMenuItems.length,
              itemBuilder: (context, index) {
                final item = saiMenuItems[index];
                return GestureDetector(
                  onTap: () {
                    final route = item['route']!;
                    final screenMap = <String, Widget>{
                      '/sai/sejarah_sai':          SejarahSaiScreen(isDark: isDark),
                      '/sai/penjelasan_sai':       PenjelasanSaiScreen(isDark: isDark),
                      '/sai/sunnah_sai':          TataCaraSaiScreen(isDark: isDark),
                      '/sai/kesalahan_sai':  HikmahKesalahanSaiScreen(isDark: isDark),
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
                          errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 40, color: Colors.grey),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item['title']!,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textClr),
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