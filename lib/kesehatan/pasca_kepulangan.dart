import 'package:flutter/material.dart';

class _PascaItem {
  final String judul;
  final List<String>? subList;
  const _PascaItem({required this.judul, this.subList});
}

const List<_PascaItem> _pascaList = [
  _PascaItem(
    judul: 'Bila menderita batuk',
    subList: [
      'Cukup istirahat',
      'Pakai masker untuk menutup mulut dan hidung',
      'Banyak minum air putih hangat',
      'Kurangi makanan berlemak, berminyak, terlalu manis atau dingin',
      'Bila batuk terus berlanjut sebaiknya ke dokter',
    ],
  ),
  _PascaItem(
    judul: 'Tetap makan dengan gizi seimbang, buah dan sayur yang cukup',
  ),
  _PascaItem(
    judul:
        'Melakukan aktivitas fisik ringan dan sedang minimal 30 menit setiap hari',
  ),
  _PascaItem(judul: 'Tidak merokok'),
  _PascaItem(judul: 'Cukup istirahat'),
];

class PascaKepulanganScreen extends StatelessWidget {
  final bool isDark;
  const PascaKepulanganScreen({super.key, this.isDark = false});

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
    final noteBg = isDark ? const Color(0xFF2A2A1A) : const Color(0xFFFFF8E7);
    final noteBorder = isDark
        ? const Color(0xFFD8AB17)
        : const Color(0xFFE6A63C);

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
                        'Pasca Kepulangan',
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
                      'Setelah Kembali ke Tanah Air',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Catatan intro
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: noteBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: noteBorder.withOpacity(0.4)),
                      ),
                      child: Text(
                        'Biasanya Jemaah haji akan mengalami batuk sekembalinya ke tanah air. '
                        'Kondisi ini diperparah bila tidak langsung istirahat.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.7,
                          color: subTextClr,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // List item
                    ..._pascaList.asMap().entries.map((entry) {
                      final i = entry.key + 1;
                      final item = entry.value;
                      final hasSubList =
                          item.subList != null && item.subList!.isNotEmpty;

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
                            if (hasSubList) ...[
                              const SizedBox(height: 10),
                              ...item.subList!.map(
                                (sub) => Padding(
                                  padding: const EdgeInsets.only(
                                    left: 38,
                                    bottom: 4,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
