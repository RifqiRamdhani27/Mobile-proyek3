import 'package:flutter/material.dart';

class _KondisiItem {
  final String judul;
  final String indonesia;
  final String arabSaudi;
  final String risiko;

  const _KondisiItem({
    required this.judul,
    required this.indonesia,
    required this.arabSaudi,
    required this.risiko,
  });
}

const List<_KondisiItem> _kondisiList = [
  _KondisiItem(
    judul: 'Suhu Udara',
    indonesia: 'Tropis',
    arabSaudi: 'Panas/Dingin Ekstrim',
    risiko: 'Gangguan adaptasi suhu udara',
  ),
  _KondisiItem(
    judul: 'Sosial Budaya',
    indonesia: 'Nasional Indonesia',
    arabSaudi: 'Internasional/Multi Budaya',
    risiko: 'Stres',
  ),
  _KondisiItem(
    judul: 'Tempat Tinggal',
    indonesia: 'Nyaman di rumah sendiri',
    arabSaudi: 'Hotel/pondokan/berpindah-pindah',
    risiko: 'Kelelahan',
  ),
  _KondisiItem(
    judul: 'Aktivitas',
    indonesia: 'Sehari-hari',
    arabSaudi: 'Kontinue, aktivitas fisik',
    risiko: 'Kelelahan',
  ),
  _KondisiItem(
    judul: 'Konsumsi Makanan',
    indonesia: 'Disesuaikan sendiri',
    arabSaudi: 'Terbatas, tidak banyak pilihan',
    risiko: 'Gangguan pencernaan',
  ),
  _KondisiItem(
    judul: 'Transportasi',
    indonesia: 'Banyak pilihan',
    arabSaudi: 'Penuh ketergantungan',
    risiko: 'Stres',
  ),
  _KondisiItem(
    judul: 'Fasilitas Kesehatan',
    indonesia: 'Dapat diakses, dekat rumah',
    arabSaudi: 'Terbatas',
    risiko: 'Penyakit berkelanjutan',
  ),
  _KondisiItem(
    judul: 'Kepadatan Orang',
    indonesia: 'Normal',
    arabSaudi: 'Sangat padat',
    risiko: 'Penularan penyakit dan cedera',
  ),
];

class KondisiKlinisScreen extends StatelessWidget {
  final bool isDark;
  const KondisiKlinisScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : Colors.black;

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
                      'Kondisi Yang Dapat Mempengaruhi Kesehatan Jemaah Haji',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ..._kondisiList.asMap().entries.map((entry) {
                      final i = entry.key + 1;
                      final item = entry.value;
                      return _KondisiCard(
                        nomor: i,
                        item: item,
                        isDark: isDark,
                        textClr: textClr,
                      );
                    }),
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

class _KondisiCard extends StatelessWidget {
  final int nomor;
  final _KondisiItem item;
  final bool isDark;
  final Color textClr;

  const _KondisiCard({
    required this.nomor,
    required this.item,
    required this.isDark,
    required this.textClr,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final subTextClr = isDark
        ? const Color(0xFFB0B0B0)
        : const Color(0xFF555555);
    final shadowClr = isDark
        ? const Color(0xFFD8AB17)
        : const Color(0xFF000000);

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
          // Judul dengan nomor
          Row(
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
                    '$nomor',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                item.judul,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textClr,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Sub item
          _subRow('Indonesia', item.indonesia, subTextClr),
          const SizedBox(height: 4),
          _subRow('Arab Saudi', item.arabSaudi, subTextClr),
          const SizedBox(height: 4),
          // Risiko highlight
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Risiko kesehatan: ',
                style: TextStyle(fontSize: 14, color: subTextClr),
              ),
              Expanded(
                child: Text(
                  item.risiko,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0ea5a4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _subRow(String label, String value, Color subTextClr) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(fontSize: 14, color: Color(0xFFE6A63C)),
        ),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: subTextClr,
          ),
        ),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 14, color: subTextClr)),
        ),
      ],
    );
  }
}
