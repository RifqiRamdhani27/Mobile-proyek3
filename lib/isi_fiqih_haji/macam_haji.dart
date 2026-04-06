import 'package:flutter/material.dart';
import '/isi_fiqih_haji/isi_macam_haji/macam_macam_haji.dart';
import '/isi_fiqih_haji/isi_macam_haji/perbedaan_jenis_haji.dart';
import '/isi_fiqih_haji/isi_macam_haji/urutan_umum_haji.dart';
import '/isi_fiqih_haji/isi_macam_haji/mengikuti_urutan.dart';

final List<Map<String, String>> macamHajiMenuItems = [
  {
    "title": "Macam-Macam Haji",
    "image": "assets/images/macam-haji.png",
    "route": "/isi_macam_haji/macam_macam_haji"
  },
  {
    "title": "Perbedaan Haji Ifrad, Qiran, dan Tamattu",
    "image": "assets/images/perbedaan-haji.png",
    "route": "/isi_macam_haji/perbedaan_jenis_haji"
  },
  {
    "title": "Urutan Umum Perjalanan Haji",
    "image": "assets/images/urutan-umum.png",
    "route": "/isi_macam_haji/urutan_umum_haji"
  },
  {
    "title": "Mengikuti Urutan Dengan Benar",
    "image": "assets/images/sunnah_ihram.png",
    "route": "/isi_macam_haji/mengikuti_urutan"
  },
];

class MacamHajiScreen extends StatelessWidget {
  final bool isDark;
  const MacamHajiScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);
    final cardBg = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF000000);
    final shadowClr = isDark ? const Color(0xFFD8AB17) : const Color(0xFF000000);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Macam Haji & Urutannya',
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
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: macamHajiMenuItems.length,
              itemBuilder: (context, index) {
                final item = macamHajiMenuItems[index];
                return GestureDetector(
                  onTap: () {
                    final route = item['route']!;
                    final screenMap = <String, Widget>{
                      '/isi_macam_haji/macam_macam_haji': MacamMacamHajiScreen(isDark: isDark),
                      '/isi_macam_haji/perbedaan_jenis_haji': PerbedaanJenisHajiScreen(isDark: isDark),
                      '/isi_macam_haji/urutan_umum_haji': UrutanUmumHajiScreen(isDark: isDark),
                      '/isi_macam_haji/mengikuti_urutan': MengikutiUrutanScreen(isDark: isDark),
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