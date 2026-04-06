import 'package:flutter/material.dart';

class SabarSaatHajiScreen extends StatelessWidget {
  final bool isDark;
  const SabarSaatHajiScreen({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);

    const bulletItems = [
      'Sabar dalam antrian',
      'Sabar menghadapi perbedaan',
      'Sabar dalam kelelahan fisik',
      'Sabar menjaga emosi',
    ];

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
                      'Sabar Saat Haji',
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
                      'Kesabaran dalam Ibadah Haji',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Ibadah haji adalah perjalanan penuh ujian. Banyaknya jamaah dari berbagai negara, cuaca yang panas, serta rangkaian ibadah yang padat membutuhkan kesabaran yang besar.',
                      style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'QS. Al-Baqarah ayat 153:',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E7),
                        border: const Border(
                          left: BorderSide(color: Color(0xFFE6A63C), width: 4),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '"Wahai orang-orang yang beriman! Mohonlah pertolongan (kepada Allah) dengan sabar dan shalat. Sesungguhnya Allah beserta orang-orang yang sabar."',
                            style: TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF1A1A1A)),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '(QS. Al-Baqarah: 153)',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Color(0xFF888888)),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Saat berhaji, kita belajar:',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                    ),
                    const SizedBox(height: 8),
                    ...bulletItems.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• ', style: TextStyle(fontSize: 15, color: textClr)),
                          Expanded(child: Text(item, style: TextStyle(fontSize: 15, color: textClr))),
                        ],
                      ),
                    )),
                    const SizedBox(height: 16),
                    Text(
                      'Dengan kesabaran, ibadah menjadi lebih tenang dan bernilai di sisi Allah.',
                      style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),
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