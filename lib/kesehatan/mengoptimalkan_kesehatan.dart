import 'package:flutter/material.dart';

class _OptimalItem {
  final String judul;
  final List<String> subList;
  const _OptimalItem({required this.judul, required this.subList});
}

const List<_OptimalItem> _optimalList = [
  _OptimalItem(
    judul: 'Ketahui status kesehatan diri sendiri',
    subList: [
      'Periksa kesehatan (medical check-up) sebelum berangkat',
      'Pastikan kondisi tubuh dalam keadaan sehat',
      'Obati penyakit terlebih dahulu sebelum perjalanan',
    ],
  ),
  _OptimalItem(
    judul: 'Imunisasi meningitis meningokokus',
    subList: [
      'Risiko penularan tinggi di tanah suci',
      'Mencegah infeksi serius (meningitis)',
      'Diberikan minimal 10 hari sebelum keberangkatan',
    ],
  ),
  _OptimalItem(
    judul: 'Rutin aktivitas fisik / olahraga',
    subList: [
      'Latihan jalan kaki atau jogging secara rutin',
      'Sesuaikan dengan kemampuan tubuh',
      'Konsultasi jika memiliki penyakit tertentu',
    ],
  ),
  _OptimalItem(
    judul: 'Jadwal latihan fisik',
    subList: [
      '3 bulan sebelum: 2x/minggu',
      '2 bulan sebelum: 3x/minggu',
      '1 bulan sebelum: 4x/minggu',
    ],
  ),
  _OptimalItem(
    judul: 'Adaptasi terhadap cuaca',
    subList: [
      'Latihan di pagi hari atau setelah subuh',
      'Biasakan di tempat terbuka',
    ],
  ),
  _OptimalItem(
    judul: 'Gizi seimbang',
    subList: [
      'Perbanyak sayur dan buah',
      'Kurangi gula dan lemak',
      'Minum air putih yang cukup',
    ],
  ),
  _OptimalItem(
    judul: 'Bawa obat pribadi',
    subList: [
      'Bawa obat ringan (batuk, flu, diare)',
      'Siapkan obat penyakit yang diderita',
    ],
  ),
  _OptimalItem(
    judul: 'Kesiapan menghadapi musim dingin',
    subList: [
      'Pakai pakaian hangat',
      'Waspadai gejala tubuh seperti menggigil',
    ],
  ),
  _OptimalItem(
    judul: 'Pencegahan',
    subList: [
      'Pakai pakaian berlapis',
      'Gunakan pelembab kulit',
      'Minum air hangat',
    ],
  ),
  _OptimalItem(
    judul: 'Kesiapan menghadapi musim panas',
    subList: [
      'Perbanyak minum air',
      'Pakai pelindung (topi/payung)',
      'Gunakan pakaian yang nyaman',
    ],
  ),
];

class MengoptimalkanKesehatanScreen extends StatelessWidget {
  final bool isDark;
  const MengoptimalkanKesehatanScreen({super.key, this.isDark = false});

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
                        'Mengoptimalkan Kesehatan',
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
                      'Mengoptimalkan Status Kesehatan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ..._optimalList.asMap().entries.map((entry) {
                      final i = entry.key + 1;
                      final item = entry.value;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
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
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item.judul,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: textClr,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ...item.subList.map(
                              (sub) => Padding(
                                padding: const EdgeInsets.only(
                                  left: 38,
                                  bottom: 4,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '• ',
                                      style: TextStyle(
                                        color: Color(0xFFE6A63C),
                                        fontSize: 14,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        sub,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: subTextClr,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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
