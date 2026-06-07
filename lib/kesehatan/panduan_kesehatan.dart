import 'package:flutter/material.dart';

class _PanduanItem {
  final String judul;
  final List<dynamic> subList; // bisa String atau _SubGroup
  const _PanduanItem({required this.judul, required this.subList});
}

class _SubGroup {
  final String judul;
  final List<String> items;
  const _SubGroup({required this.judul, required this.items});
}

const List<_PanduanItem> _panduanList = [
  _PanduanItem(
    judul: 'Jaga Pola Makan',
    subList: [
      'Makan teratur 3 kali sehari, jangan terlambat',
      'Perbanyak karbohidrat (nasi, mi, kentang, roti)',
      'Minum susu setiap hari',
      'Perbanyak sayur dan tambahkan vitamin bila perlu',
      'Pilih makanan bersih dan aman',
      'Perhatikan kadaluarsa makanan',
      'Cek makanan katering masih layak atau tidak',
      'Makanan katering segera dikonsumsi (maks 2 jam)',
      'Minum air minimal 1 gelas tiap jam',
      'Hindari makan terlalu kenyang & berlemak saat perjalanan',
      'Cuci tangan sebelum & sesudah makan',
    ],
  ),
  _PanduanItem(
    judul: 'Menjaga Kebersihan Diri dan Lingkungan',
    subList: [
      _SubGroup(
        judul: 'Kebersihan Diri',
        items: [
          'Mandi minimal 1 kali sehari',
          'Gunakan masker (dibasahi) untuk mencegah debu',
          'Gunakan nasal spray agar hidung tidak kering',
          'Cuci tangan sebelum makan & setelah dari toilet',
        ],
      ),
      _SubGroup(
        judul: 'Kebersihan Lingkungan',
        items: [
          'Jaga kebersihan kamar & barang',
          'Jemur pakaian pada tempatnya',
          'Tidak merokok (risiko kebakaran)',
          'Buang sampah pada tempatnya',
        ],
      ),
      _SubGroup(
        judul: 'Kebersihan Toilet / WC',
        items: [
          'Sediakan plastik untuk sampah (tisu/pembalut)',
          'Pilih toilet yang bersih & tidak becek',
          'Bersihkan sebelum & sesudah digunakan',
        ],
      ),
    ],
  ),
];

class PanduanKesehatanScreen extends StatelessWidget {
  final bool isDark;
  const PanduanKesehatanScreen({super.key, this.isDark = false});

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
    final subGroupClr = isDark
        ? const Color(0xFFE0C070)
        : const Color(0xFF1A1A1A);
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
                        'Panduan Kesehatan',
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
                      'Panduan Menjaga Kesehatan Selama Haji',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ..._panduanList.asMap().entries.map((entry) {
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
                            // Nomor + Judul
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

                            // Sub items — bisa String biasa atau _SubGroup
                            ...item.subList.map((sub) {
                              if (sub is String) {
                                return Padding(
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
                                );
                              } else if (sub is _SubGroup) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 38,
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Sub-group title
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 6,
                                        ),
                                        child: Text(
                                          sub.judul,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: subGroupClr,
                                          ),
                                        ),
                                      ),
                                      // Sub-group items
                                      ...sub.items.map(
                                        (it) => Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12,
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
                                                  it,
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
                              }
                              return const SizedBox.shrink();
                            }),
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
