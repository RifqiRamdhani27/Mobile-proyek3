import 'package:flutter/material.dart';

import '../kesehatan/kesehatan_haji.dart';
import '../kesehatan/kebijakan_haji.dart';
import '../kesehatan/kondisi_utama.dart';
import '../kesehatan/mengoptimalkan_kesehatan.dart';
import '../kesehatan/panduan_kesehatan.dart';
import '../kesehatan/pasca_kepulangan.dart';
import '../kesehatan/tips_kesehatan.dart';
import '../kesehatan/rekomendasi_buah.dart';

class KesehatanItem {
  final String image;
  final String label;

  const KesehatanItem({required this.image, required this.label});
}

const List<KesehatanItem> _items = [
  KesehatanItem(
    image: 'assets/images/resiko.kesehatan1.png',
    label: 'Kesehatan Haji',
  ),
  KesehatanItem(
    image: 'assets/images/regulasi.png',
    label: 'kebijakan haji jamaah indonesia',
  ),
  KesehatanItem(image: 'assets/images/kliniks.png', label: 'Kondisi Utama'),
  KesehatanItem(
    image: 'assets/images/status.kesehatan.png',
    label: 'Mengoptimalkan Kesehatan',
  ),
  KesehatanItem(
    image: 'assets/images/panduan.png',
    label: 'Panduan menjaga kesehatan selama Haji',
  ),
  KesehatanItem(image: 'assets/images/sujud.png', label: 'Pasca Kepulangan'),
  KesehatanItem(
    image: 'assets/images/tips.kesehatan.png',
    label: 'Tips Kesehatan di Tanah Suci',
  ),
  KesehatanItem(
    image: 'assets/images/sunnah_ihram.png',
    label: 'Rekomendasi Buah & Sayur',
  ),
];

class KesehatanScreen extends StatelessWidget {
  final bool isDark;
  const KesehatanScreen({super.key, this.isDark = false});

  void _navigateTo(BuildContext context, int index) {
    // Screen yang sudah ada filenya
    final Map<int, Widget> availableScreens = {
      0: KondisiKlinisScreen(isDark: isDark),
      1: KebijakanHajiScreen(isDark: isDark),
      2: KondisiIstithaahScreen(isDark: isDark),
      3: MengoptimalkanKesehatanScreen(isDark: isDark),
      4: PanduanKesehatanScreen(isDark: isDark),
      5: PascaKepulanganScreen(isDark: isDark),
      6: TipsKesehatanScreen(isDark: isDark),
      7: RekomendasiBuahScreen(isDark: isDark),
    };

    final screen = availableScreens[index];
    if (screen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Fitur ini belum tersedia')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

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
                        'Kesehatan',
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
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _KesehatanCard(
                      item: _items[index],
                      isDark: isDark,
                      onTap: () => _navigateTo(context, index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KesehatanCard extends StatefulWidget {
  final KesehatanItem item;
  final bool isDark;
  final VoidCallback onTap;
  const _KesehatanCard({
    required this.item,
    required this.onTap,
    this.isDark = false,
  });

  @override
  State<_KesehatanCard> createState() => _KesehatanCardState();
}

class _KesehatanCardState extends State<_KesehatanCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final cardBg = widget.isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textClr = widget.isDark
        ? const Color(0xFFE0C070)
        : const Color(0xFF000000);
    final shadowClr = widget.isDark
        ? const Color(0xFFD8AB17)
        : const Color(0xFF000000);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowClr.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                widget.item.image,
                width: 40,
                height: 40,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.health_and_safety_outlined,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.item.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textClr,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: widget.isDark
                    ? const Color(0xFFC9A84C)
                    : const Color(0xFFE6A63C),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
