import 'package:flutter/material.dart';

const _lokasiMekkah = [
  {
    'nama': "Masjidil Haram & Ka'bah",
    'lokasi': 'Pusat Kota Mekkah',
    'desc': "Masjid terbesar di dunia. Di dalamnya terdapat Ka'bah sebagai kiblat umat Islam, Maqam Ibrahim, Hijir Ismail, Sumur Zamzam, serta Bukit Shafa dan Marwah.",
  },
  {
    'nama': 'Gua Hira (Jabal Nur)',
    'lokasi': '±6 km utara Masjidil Haram',
    'desc': 'Tempat Nabi Muhammad ﷺ menerima wahyu pertama (QS. Al-Alaq: 1-5). Perlu mendaki sekitar 1 jam untuk sampai ke puncak.',
  },
  {
    'nama': 'Gua Tsur (Jabal Tsur)',
    'lokasi': 'Selatan Mekkah',
    'desc': 'Tempat Nabi Muhammad ﷺ dan Abu Bakar bersembunyi dari kejaran kaum Quraisy saat hendak hijrah ke Madinah.',
  },
  {
    'nama': 'Jabal Rahmah',
    'lokasi': 'Padang Arafah, ±20 km dari Mekkah',
    'desc': 'Bukit setinggi 70 meter tempat bertemunya Nabi Adam dan Siti Hawa setelah diturunkan dari surga. Terdapat tugu di puncaknya.',
  },
  {
    'nama': "Jannat al-Mu'alla (Maqbarah Ma'la)",
    'lokasi': 'Dekat Masjidil Haram',
    'desc': 'Pemakaman tua tempat dimakamkannya Siti Khadijah (istri Nabi), putra-putranya Qasim & Abdullah, serta para sahabat terkemuka.',
  },
  {
    'nama': 'Masjid Tan\'im (Masjid Aisyah)',
    'lokasi': '±7 km dari Masjidil Haram',
    'desc': 'Miqat paling populer bagi jamaah yang ingin melaksanakan umroh dari dalam Mekkah. Di sinilah Sayyidah Aisyah memulai ihramnya.',
  },
  {
    'nama': 'Masjid Namirah',
    'lokasi': 'Arafah',
    'desc': 'Tempat Rasulullah ﷺ menyampaikan khutbah terakhir pada Haji Wada\'. Digunakan saat puncak ibadah haji.',
  },
  {
    'nama': 'Masjid Al-Khaif',
    'lokasi': 'Mina',
    'desc': 'Tempat Nabi Muhammad ﷺ dan banyak nabi terdahulu pernah shalat. Terletak strategis di kawasan Mina.',
  },
  {
    'nama': 'Masjid Jin',
    'lokasi': '±3 km dari Masjidil Haram',
    'desc': 'Masjid yang dibangun di lokasi Nabi Muhammad ﷺ bertemu sekelompok jin yang kemudian memeluk Islam.',
  },
  {
    'nama': 'Tempat Wukuf Arafah',
    'lokasi': 'Padang Arafah',
    'desc': 'Lokasi pelaksanaan wukuf pada 9 Dzulhijjah — puncak ibadah haji. Simbol persatuan umat Islam dari seluruh dunia.',
  },
];

class MekkahScreen extends StatelessWidget {
  final bool isDark;
  const MekkahScreen({super.key, required this.isDark});

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
                        'Lokasi Ziarah Mekkah',
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
                      'Tempat Ziarah di Mekkah',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE6A63C)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mekkah menyimpan banyak situs bersejarah yang menjadi saksi perjalanan dakwah Islam sejak zaman Nabi Ibrahim hingga Rasulullah ﷺ.',
                      style: TextStyle(fontSize: 14, height: 1.6, color: textClr),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    ..._lokasiMekkah.asMap().entries.map((entry) {
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