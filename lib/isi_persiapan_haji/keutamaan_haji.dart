import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeutamaanHajiScreen extends StatelessWidget {
  final bool isDark;
  const KeutamaanHajiScreen({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);

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
                      'Keutamaan Haji',
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Keutamaan Haji',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tidak ada yang ragu bahwasanya haji merupakan ibadah yang dirindukan '
                      'oleh setiap muslim di atas muka bumi ini, yang kalau kita mendengar '
                      'cerita tentang bagaimana kerinduan kaum muslimin terhadap ibadah haji '
                      'sungguh sangat luar biasa.\n\n'
                      'Mulai orang-orang yang mengumpulkan uang bertahun-tahun bahkan puluhan '
                      'tahun agar bisa berangkat ke tanah suci untuk melaksanakan ibadah.\n\n'
                      'Kita dengar juga cerita ada sebagian wanita Indonesia yang tatkala '
                      'sampai di Saudi mereka langsung sujud syukur, begitu luar biasa bahkan '
                      'banyak yang bercita-cita ingin meninggal tatkala haji, ingin meninggal '
                      'di tanah suci dan terlalu banyak cerita yang menjelaskan tentang '
                      'bagaimana luar biasanya kerinduan kaum Muslimin terhadap ibadah haji.',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: textClr,
                      ),
                      textAlign: TextAlign.justify,
                    ),
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