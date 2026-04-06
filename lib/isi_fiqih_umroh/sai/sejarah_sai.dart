import 'package:flutter/material.dart';

class SejarahSaiScreen extends StatelessWidget {
  final bool isDark;
  const SejarahSaiScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg       = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr  = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
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
                        "Sejarah Sa'i",
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
                  const Text(
                    'Sejarah Ibadah Sa\'i',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE6A63C),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Sa'i bermula dari kisah Siti Hajar, istri Nabi Ibrahim 'alaihis salam, ketika mencari air untuk putranya Nabi Ismail di lembah yang tandus.",
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Beliau berlari antara bukit Shafa dan Marwah sebanyak tujuh kali karena melihat anaknya kehausan. Atas pertolongan Allah, muncullah air Zamzam dari dekat kaki Nabi Ismail.',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Peristiwa ini kemudian dijadikan bagian dari ibadah haji dan umroh.',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Allah berfirman dalam QS. Al-Baqarah ayat 158:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E7),
                      borderRadius: BorderRadius.circular(8),
                      border: const Border(
                        left: BorderSide(color: Color(0xFFE6A63C), width: 4),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Column(
                      children: [
                        Text(
                          '"Sesungguhnya Shafa dan Marwah adalah sebagian dari syiar Allah."',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF1A1A1A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(QS. Al-Baqarah: 158)',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF888888),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Sa'i mengingatkan kita pada perjuangan, kesabaran, dan tawakal Siti Hajar.",
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