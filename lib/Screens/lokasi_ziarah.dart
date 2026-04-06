import 'package:flutter/material.dart';
import '../isi_lokasi_ziarah/mekkah.dart';
import '../isi_lokasi_ziarah/madinah.dart';

class LokasiZiarahScreen extends StatelessWidget {
  final bool isDark;
  const LokasiZiarahScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg        = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);
    final cardBg    = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
    final textClr   = isDark ? const Color(0xFFE0C070) : const Color(0xFF000000);
    final shadowClr = isDark ? const Color(0xFFD8AB17) : const Color(0xFF000000);

    final menuItems = [
      {
        'title': 'Mekkah',
        'image': 'assets/images/mekkah.png',
        'screen': MekkahScreen(isDark: isDark),
      },
      {
        'title': 'Madinah',
        'image': 'assets/images/madinah.png',
        'screen': MadinahScreen(isDark: isDark),
      },
    ];

    return Scaffold(
      backgroundColor: bg,
      body: Column(
        children: [
          Container(
            height: 95,
            color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400),
            child: SafeArea(
              bottom: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '←',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: isDark ? const Color(0xFFC9A84C) : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Lokasi Ziarah',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? const Color(0xFFC9A84C) : Colors.black,
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
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => item['screen'] as Widget),
                  ),
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
                          item['image'] as String,
                          width: 40,
                          height: 40,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 40, color: Colors.grey),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item['title'] as String,
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