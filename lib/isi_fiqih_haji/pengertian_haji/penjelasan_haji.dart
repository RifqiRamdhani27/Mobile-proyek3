import 'package:flutter/material.dart';

class PenjelasanHajiScreen extends StatelessWidget {
  final bool isDark;
  const PenjelasanHajiScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg      = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    return Scaffold(
      backgroundColor: bg,
      body: Column(
        children: [
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
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: titleClr),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Penjelasan Haji',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: titleClr),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Pengertian Haji',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE6A63C)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Haji adalah ibadah yang dilakukan dengan mengunjungi Baitullah (Ka\'bah) di Makkah pada waktu tertentu, dengan tata cara tertentu sesuai syariat Islam.',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Secara bahasa, haji berarti "menuju" atau "mengunjungi". Secara istilah, haji adalah ibadah kepada Allah dengan melakukan rangkaian amalan seperti ihram, wukuf di Arafah, thawaf, sa\'i, dan tahallul.',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Haji termasuk rukun Islam kelima yang wajib bagi setiap muslim yang mampu.',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}