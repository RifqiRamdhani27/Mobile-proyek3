import 'package:flutter/material.dart';

const List<String> _buahList = [
  'Pilih buah yang dapat menambah energi dan memulihkan stamina dengan cepat seperti kurma, pisang, dan anggur (termasuk kismis)',
  'Untuk menghindari asam lambung, konsumsi buah yang bersifat basa seperti kurma, pepaya, pir, kiwi, pisang, apel, tomat, dan anggur',
  'Saat batuk, pilih buah dengan asam sitrat rendah dan serat tidak terlalu kasar. Hindari atau batasi jeruk, mangga, nanas, stroberi',
  'Bagi penderita diabetes, konsumsi buah tetap diperbolehkan namun perlu memperhatikan jenis dan jumlah agar gula darah tetap stabil',
];

class RekomendasiBuahScreen extends StatelessWidget {
  final bool isDark;
  const RekomendasiBuahScreen({super.key, this.isDark = false});

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
                        'Rekomendasi Buah & Sayur',
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
                      'Pilihan Konsumsi Buah',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Paragraf intro
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: noteBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: noteBorder.withOpacity(0.4)),
                      ),
                      child: Text(
                        'Pada prinsipnya semua buah-buahan baik karena mengandung air, serat, dan vitamin yang dibutuhkan tubuh. '
                        'Namun, selama di tanah suci kita harus cermat dalam mengonsumsinya agar terhindar dari gangguan kesehatan '
                        'seperti diare atau asam lambung berlebih (gastritis/maag).',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.7,
                          color: subTextClr,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sub title
                    Text(
                      'Tips mengonsumsi buah selama ibadah haji:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textClr,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // List tips
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
                        children: _buahList.asMap().entries.map((entry) {
                          final i = entry.key + 1;
                          final text = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
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
