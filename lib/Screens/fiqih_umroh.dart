import 'package:flutter/material.dart';
import '../isi_fiqih_umroh/ihram_miqot.dart';
import '../isi_fiqih_umroh/thowaf.dart';
import '../isi_fiqih_umroh/makam-ibrahim.dart';
import '../isi_fiqih_umroh/minum-air-zamzam.dart';
import '../isi_fiqih_umroh/sai.dart';
import '../isi_fiqih_umroh/gundul.dart';

final List<Map<String, String>> fiqihUmrohMenuItems = [
  {"title": "Ihram Miqot",                  "image": "assets/images/ihram_miqot.png",      "route": "/ihram_miqot"},
  {"title": "Thowaf",                        "image": "assets/images/thowaf.png",            "route": "/thowaf"},
  {"title": "Makam Ibrahim",                 "image": "assets/images/makam_ibrahim.png",     "route": "/makam-ibrahim"},
  {"title": "Minum Air Zamzam",              "image": "assets/images/minum_air_zamzam.png",  "route": "/minum-air-zamzam"},
  {"title": "Sa'i",                          "image": "assets/images/sa'i2.png",             "route": "/sai"},
  {"title": "Gundul / Cukuran Umroh & haji", "image": "assets/images/gundul.png",            "route": "/gundul"},
];

class FiqihUmrohScreen extends StatelessWidget {
  final bool isDark;
  const FiqihUmrohScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg        = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);
    final cardBg    = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
    final textClr   = isDark ? const Color(0xFFE0C070) : const Color(0xFF000000);
    final shadowClr = isDark ? const Color(0xFFD8AB17) : const Color(0xFF000000);
    final appBarBg  = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr  = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) Navigator.pop(context);
      },
      child: Scaffold(
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
                        'Fiqih Umroh',
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
                itemCount: fiqihUmrohMenuItems.length,
                itemBuilder: (context, index) {
                  final item = fiqihUmrohMenuItems[index];
                  return GestureDetector(
                    onTap: () {
                      final route = item['route']!;
                      final screenMap = <String, Widget>{
                        '/ihram_miqot':      IhramMiqotScreen(isDark: isDark),
                        '/thowaf':           ThowafScreen(isDark: isDark),
                        '/makam-ibrahim':    MakamIbrahimScreen(isDark: isDark),
                        '/minum-air-zamzam': MinumAirZamzamScreen(isDark: isDark),
                        '/sai':                 SaiScreen(isDark: isDark),
                        '/gundul':           GundulScreen(isDark: isDark),
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
      ),
    );
  }
}