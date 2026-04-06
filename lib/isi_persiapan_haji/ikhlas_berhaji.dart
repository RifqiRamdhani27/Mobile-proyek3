import 'package:flutter/material.dart';

class IkhlasBerhajiScreen extends StatelessWidget {
  final bool isDark;
  const IkhlasBerhajiScreen({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);

    const bulletItems = [
      'Berhaji hanya mengharap ridha Allah',
      'Tidak riya (ingin dipuji)',
      'Tidak membanggakan diri setelah pulang haji',
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
                        child: Text('←', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: isDark ? const Color(0xFFC9A84C) : Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('Ikhlas Berhaji', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? const Color(0xFFC9A84C) : Colors.black)),
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
                    const Text('Ikhlas dalam Berhaji', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE6A63C))),
                    const SizedBox(height: 16),
                    Text('Haji harus dilandasi niat yang ikhlas karena Allah, bukan untuk gelar, pujian, atau kebanggaan.', style: TextStyle(fontSize: 15, height: 1.6, color: textClr), textAlign: TextAlign.justify),
                    const SizedBox(height: 16),
                    Text('QS. Al-Bayyinah ayat 5:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr)),
                    const SizedBox(height: 8),
                    _ayatBox('"Padahal mereka hanya diperintah menyembah Allah dengan ikhlas menaati-Nya dalam menjalankan agama."', '(QS. Al-Bayyinah: 5)'),
                    Text('Ikhlas berarti:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr)),
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
                    Text('Ibadah yang ikhlas akan melahirkan haji yang mabrur dan perubahan diri yang lebih baik.', style: TextStyle(fontSize: 15, height: 1.6, color: textClr), textAlign: TextAlign.justify),
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

  Widget _ayatBox(String text, String source) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        border: const Border(left: BorderSide(color: Color(0xFFE6A63C), width: 4)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF1A1A1A)), textAlign: TextAlign.justify),
          const SizedBox(height: 8),
          Text(source, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Color(0xFF888888))),
        ],
      ),
    );
  }
}