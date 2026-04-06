import 'package:flutter/material.dart';
import '../isi_fiqih_haji/pengertian_haji/penjelasan_haji.dart';
import '../isi_fiqih_haji/pengertian_haji/hukum_haji.dart';
import '../isi_fiqih_haji/pengertian_haji/syarat_wajib_haji.dart';
import '../isi_fiqih_haji/pengertian_haji/syarat_sah_haji.dart';

final List<Map<String, String>> pengertianHajiMenuItems = [
  {"title": "Penjelasan Haji",   "image": "assets/images/penjelasan_haji.png", "route": "/pengertian_haji/penjelasan_haji"},
  {"title": "Hukum Haji",        "image": "assets/images/hukum.png",           "route": "/pengertian_haji/hukum_haji"},
  {"title": "Syarat Wajib Haji", "image": "assets/images/syarat.png",          "route": "/pengertian_haji/syarat_wajib_haji"},
  {"title": "Syarat Sah Haji",   "image": "assets/images/syarat_sah.png",      "route": "/pengertian_haji/syarat_sah_haji"},
];

class PengertianHukumSyaratHajiScreen extends StatelessWidget {
  final bool isDark;
  const PengertianHukumSyaratHajiScreen({super.key, this.isDark = false});

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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Pengertian, Hukum & Syarat Haji',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: titleClr),
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
              itemCount: pengertianHajiMenuItems.length,
              itemBuilder: (context, index) {
                final item = pengertianHajiMenuItems[index];
                return GestureDetector(
                  onTap: () {
                    final route = item['route']!;
                    final screenMap = <String, Widget>{
                      '/pengertian_haji/penjelasan_haji':   PenjelasanHajiScreen(isDark: isDark),
                      '/pengertian_haji/hukum_haji':        HukumHajiScreen(isDark: isDark),
                      '/pengertian_haji/syarat_wajib_haji': SyaratWajibHajiScreen(isDark: isDark),
                      '/pengertian_haji/syarat_sah_haji':   SyaratSahHajiScreen(isDark: isDark),
                    };
                    final screen = screenMap[route];
                    if (screen != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
                    }
                  },
                  child: Container(
                    height: 70,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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