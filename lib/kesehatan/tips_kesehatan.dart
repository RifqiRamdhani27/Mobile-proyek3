import 'package:flutter/material.dart';

const List<String> _tipsList = [
  'Selalu membawa kartu kesehatan haji',
  'Tetap melakukan aktivitas olahraga rutin yang ringan',
  'Rutin memeriksa kesehatan di pelayanan kesehatan bagi yang memiliki penyakit kronis seperti hipertensi, hipotensi, diabetes',
  'Selalu ingat minum obat rutin bila memiliki penyakit yang memerlukan pengobatan terus menerus',
  'Beribadah sesuai kemampuan, tidak memaksakan ibadah sunnah bila tidak mampu',
  'Cukup istirahat, tidak banyak berjalan di luar ibadah pokok',
  'Hindari tempat yang berdesakan',
  'Cukup minum air dan cairan tubuh, bawa botol minum',
  'Siapkan obat pribadi seperti obat lambung, flu, dan anti nyeri',
  'Ketahui lokasi pelayanan kesehatan haji dan nomor darurat',
  'Segera lapor ke petugas kesehatan jika sakit tidak kunjung sembuh',
  'Biasakan istinsyaq saat wudhu untuk menjaga saluran pernapasan',
  'Gunakan pelembab wajah untuk mencegah kulit kering',
  'Gunakan pelembab kaki untuk mencegah tumit pecah-pecah',
];

class TipsKesehatanScreen extends StatelessWidget {
  final bool isDark;
  const TipsKesehatanScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : Colors.black;
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final subTextClr = isDark
        ? const Color(0xFFB0B0B0)
        : const Color(0xFF555555);
    final shadowClr = isDark
        ? const Color(0xFFD8AB17)
        : const Color(0xFF000000);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: bg,
        body: Column(
          children: [
            // ── Header ──
            Container(
              height: 115,
              color: appBarBg,
              child: SafeArea(
                bottom: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Transform.translate(
                        offset: const Offset(10, -3.5),
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
                    Transform.translate(
                      offset: const Offset(15, 2),
                      child: Text(
                        'Tips Kesehatan',
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

            // ── Konten ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Tips Kesehatan di Tanah Suci',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: shadowClr.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: _tipsList.asMap().entries.map((entry) {
                          final i = entry.key + 1;
                          final text = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE6A63C),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$i',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    text,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: subTextClr,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
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
