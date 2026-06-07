import 'package:flutter/material.dart';

class _KondisiUtama {
  final String judul;
  final List<String> subList;
  const _KondisiUtama({required this.judul, required this.subList});
}

const List<_KondisiUtama> _kondisiUtamaList = [
  _KondisiUtama(
    judul: 'Kondisi Klinis Mengancam Jiwa',
    subList: [
      'Penyakit Paru Obstruktif Kronik stadium IV',
      'Gagal jantung stadium IV',
      'Penyakit ginjal kronik stadium IV dengan dialisis',
      'AIDS stadium IV dengan infeksi oportunistik',
      'Stroke perdarahan yang luas',
    ],
  ),
  _KondisiUtama(
    judul: 'Gangguan Jiwa Berat',
    subList: ['Skizofrenia berat', 'Dementia berat', 'Retardasi mental berat'],
  ),
  _KondisiUtama(
    judul: 'Penyakit yang Sulit Diharapkan Kesembuhannya',
    subList: [
      'Keganasan stadium akhir',
      'Tuberkulosis resisten obat',
      'Penyakit hati sirosis/hepatoma decompensate',
    ],
  ),
];

const List<String> _risikoTinggi = [
  'Hipertensi',
  'Diabetes mellitus',
  'Gangguan metabolisme',
  'Kardiomegali',
  'Obesitas',
  'Tekanan darah rendah',
  'Asma',
  'Penyakit jantung',
  'Kepikunan',
  'PPOK & pneumonia',
];

class KondisiIstithaahScreen extends StatelessWidget {
  final bool isDark;
  const KondisiIstithaahScreen({super.key, this.isDark = false});

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
                        'Kondisi Klinis',
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
                      'Kondisi Klinis Yang Tidak Memenuhi Syarat Istithaah (Mampu) Kesehatan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // List kondisi utama
                    ..._kondisiUtamaList.asMap().entries.map((entry) {
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

                    // Catatan
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Beberapa penyakit risiko tinggi dapat dicegah dengan persiapan dan pengetahuan yang baik dalam menghadapi perubahan kondisi.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: subTextClr,
                        ),
                      ),
                    ),

                    // Judul risiko tinggi
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 14),
                      child: Text(
                        'Penyakit risiko tinggi:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textClr,
                        ),
                      ),
                    ),

                    // List risiko tinggi
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
                        children: _risikoTinggi.asMap().entries.map((entry) {
                          final i = entry.key + 1;
                          final text = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
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
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    text,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.5,
                                      color: textClr,
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
