import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final List<Map<String, String>> fiqihHajiMenuItems = [
  {"title": "Pengertian, Hukum & Syarat Haji", "image": "assets/images/haji_tamattu.png",    "route": "/pengertian-hukum-syarat-haji"},
  {"title": "Rukun & Wajib Haji",              "image": "assets/images/haji_ifrod.png",       "route": "/rukun-wajib-haji"},
  {"title": "Macam Haji dan Urutannya",         "image": "assets/images/haji_qiron.png",       "route": "/macam-haji"},
  {"title": "Larangan, Hikmah & Keutamaan Haji","image": "assets/images/pelaksanaan_haji.png", "route": "/larangan-haji"},
];

class FiqihHajiScreen extends StatefulWidget {
  final bool isDark;
  const FiqihHajiScreen({super.key, this.isDark = false});

  @override
  State<FiqihHajiScreen> createState() => _FiqihHajiScreenState();
}

class _FiqihHajiScreenState extends State<FiqihHajiScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark    = widget.isDark;
    final bg        = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);
    final cardBg    = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
    final textClr   = isDark ? const Color(0xFFE0C070) : const Color(0xFF000000);
    final shadowClr = isDark ? const Color(0xFFD8AB17) : const Color(0xFF000000);
    final appBarBg  = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr  = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: bg,
        body: Column(
          children: [
            // ── AppBar ──────────────────────────────────────────────────────
            Container(
              height: 95,
              color: appBarBg,
              child: SafeArea(
                bottom: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, left: 8),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Fiqih Haji',
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

            // ── List Menu ──────────────────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: fiqihHajiMenuItems.length,
                itemBuilder: (context, index) {
                  final item = fiqihHajiMenuItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, item['route']!);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
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
                            item['image']!,
                            width: 40,
                            height: 40,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.image,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              item['title']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: textClr,
                              ),
                            ),
                          ),
                        ],
                      ),
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