import 'package:flutter/material.dart';
import '../isi_persiapan_haji/keutamaan_haji.dart';
import '../isi_persiapan_haji/makna_jamaah_haji.dart';
import '../isi_persiapan_haji/motivasi_berhaji.dart';
import '../isi_persiapan_haji/sabar_saat_haji.dart';
import '../isi_persiapan_haji/ikhlas_berhaji.dart';
import '../isi_persiapan_haji/teladan_rasulullah.dart';
import '../isi_persiapan_haji/jaga_haji_agar_mabrur.dart';

final List<Map<String, String>> menuItems = [
  {"title": "Keutamaan Haji",       "image": "assets/images/keutamaan_haji.png",       "route": "/isi_persiapan_haji/keutamaan_haji"},
  {"title": "Makna Jamaah Haji",    "image": "assets/images/makna_jemaah_haji.png",    "route": "/isi_persiapan_haji/makna_jamaah_haji"},
  {"title": "Motivasi Berhaji",     "image": "assets/images/motivasi_berhaji.png",     "route": "/isi_persiapan_haji/motivasi_berhaji"},
  {"title": "Sabar Saat Haji",      "image": "assets/images/sabar_saat_haji.png",      "route": "/isi_persiapan_haji/sabar_saat_haji"},
  {"title": "Ikhlas Berhaji",       "image": "assets/images/ikhlas_berhaji.png",       "route": "/isi_persiapan_haji/ikhlas_berhaji"},
  {"title": "Teladan Rasulullah",   "image": "assets/images/teladan_rasulullah.png",   "route": "/isi_persiapan_haji/teladan_rasulullah"},
  {"title": "Jaga Haji agar Mabrur","image": "assets/images/jaga_haji_agar_mabrur.png","route": "/isi_persiapan_haji/jaga_haji_agar_mabrur"},
];

class PersiapanHajiScreen extends StatelessWidget {
  final bool isDark;
  const PersiapanHajiScreen({super.key, this.isDark = false});

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
                      '/isi_persiapan_haji/keutamaan_haji':        KeutamaanHajiScreen(isDark: isDark),
                      '/isi_persiapan_haji/makna_jamaah_haji':     MaknaJamaahHajiScreen(isDark: isDark),
                      '/isi_persiapan_haji/motivasi_berhaji':      MotivasiBerhajiScreen(isDark: isDark),
                      '/isi_persiapan_haji/sabar_saat_haji':       SabarSaatHajiScreen(isDark: isDark),
                      '/isi_persiapan_haji/ikhlas_berhaji':        IkhlasBerhajiScreen(isDark: isDark),
                      '/isi_persiapan_haji/teladan_rasulullah':    TeladanRasulullahScreen(isDark: isDark),
                      '/isi_persiapan_haji/jaga_haji_agar_mabrur': JagaHajiAgarMabrurScreen(isDark: isDark),
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