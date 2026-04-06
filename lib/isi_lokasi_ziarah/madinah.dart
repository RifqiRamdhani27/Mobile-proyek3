import 'package:flutter/material.dart';

const _lokasiMadinah = [
  {
    'nama': 'Masjid Nabawi',
    'lokasi': 'Pusat Kota Madinah',
    'desc': 'Masjid kedua yang dibangun Rasulullah ﷺ. Di dalamnya terdapat makam Nabi Muhammad ﷺ, Abu Bakar, dan Umar bin Khattab. Shalat di sini senilai 1.000 kali lipat dibanding masjid lain.',
  },
  {
    'nama': 'Raudhah (Taman Surga)',
    'lokasi': 'Di dalam Masjid Nabawi',
    'desc': 'Area antara mimbar dan makam Rasulullah ﷺ yang disebut sebagai taman surga. Salah satu tempat mustajab untuk berdoa. Kunjungan perlu jadwal via aplikasi Nusuk.',
  },
  {
    'nama': 'Pemakaman Baqi (Jannatul Baqi)',
    'lokasi': 'Sisi timur Masjid Nabawi',
    'desc': 'Pemakaman ribuan sahabat Nabi, termasuk istri-istri beliau seperti Aisyah r.a., anak, dan cucu beliau. Suasana sangat khidmat dan penuh sejarah.',
  },
  {
    'nama': 'Masjid Quba',
    'lokasi': '±5 km dari Masjid Nabawi',
    'desc': 'Masjid pertama yang dibangun Rasulullah ﷺ setelah hijrah. Shalat 2 rakaat di sini pahalanya setara umroh. Disebut dalam QS. At-Taubah: 108.',
  },
  {
    'nama': 'Jabal Uhud & Makam Syuhada',
    'lokasi': '±5 km utara Madinah',
    'desc': 'Lokasi Perang Uhud. Di sini dimakamkan para syuhada termasuk Hamzah bin Abdul Muttalib, paman Nabi. Tempat ziarah yang penuh makna pengorbanan.',
  },
  {
    'nama': 'Masjid Qiblatain',
    'lokasi': 'Barat laut Madinah',
    'desc': "Masjid dengan dua arah kiblat — saksi sejarah perpindahan kiblat dari Masjidil Aqsa ke Ka'bah. Simbol ketaatan kepada perintah Allah.",
  },
  {
    'nama': 'Masjid Bir Ali (Masjid Miqat)',
    'lokasi': '±9 km dari Masjid Nabawi',
    'desc': 'Miqat bagi jamaah yang berangkat dari Madinah menuju Mekkah untuk berihram. Dikenal juga sebagai Masjid Abyar Ali.',
  },
  {
    'nama': 'Wadi Jin (Bukit Magnet)',
    'lokasi': 'Luar kota Madinah',
    'desc': 'Bukit dengan medan magnet unik. Kendaraan yang dimatikan mesinnya akan bergerak sendiri seolah tertarik. Fenomena alam yang menakjubkan.',
  },
];

class MadinahScreen extends StatelessWidget {
  final bool isDark;
  const MadinahScreen({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bg        = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final cardBg    = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
    final textClr   = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final subClr    = isDark ? const Color(0xFFAAAAAA) : const Color(0xFF555555);
    final shadowClr = isDark ? const Color(0xFFD8AB17) : const Color(0xFF000000);

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
                    Expanded(
                      child: Text(
                        'Lokasi Ziarah Madinah',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? const Color(0xFFC9A84C) : Colors.black,
                        ),
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
                      'Tempat Ziarah di Madinah',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE6A63C)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Madinah Al-Munawwarah adalah kota suci kedua dalam Islam, penuh dengan jejak langkah Rasulullah ﷺ dan para sahabat mulia.',
                      style: TextStyle(fontSize: 14, height: 1.6, color: textClr),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    ..._lokasiMadinah.asMap().entries.map((entry) {
                      final i = entry.key;
                      final item = entry.value;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: shadowClr.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${i + 1}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE6A63C)),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item['nama']!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr)),
                                      const SizedBox(height: 2),
                                      Text('📍 ${item['lokasi']}', style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Color(0xFFE6A63C))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(item['desc']!, style: TextStyle(fontSize: 13, height: 1.5, color: subClr), textAlign: TextAlign.justify),
                          ],
                        ),
                      );
                    }),
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