import 'package:flutter/material.dart';

class PenjelasanMakamIbrahimScreen extends StatelessWidget {
  final bool isDark;
  const PenjelasanMakamIbrahimScreen({super.key, this.isDark = false});

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
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: titleClr,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Penjelasan Makam Ibrahim',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: titleClr,
                        ),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/makam_ibrahim2.png',
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox(
                        height: 160,
                        child: Center(child: Icon(Icons.image, size: 48, color: Colors.grey)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Makam Ibrahim',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Makam Ibrahim adalah batu tempat berdirinya Nabi Ibrahim \'alaihis salam ketika membangun Ka\'bah bersama putranya, Nabi Ismail.',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Di atas batu tersebut terdapat bekas telapak kaki Nabi Ibrahim sebagai tanda sejarah yang dijaga hingga sekarang.',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Allah SWT berfirman dalam QS. Al-Baqarah ayat 125:',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '"Dan jadikanlah sebagian Maqam Ibrahim sebagai tempat shalat."',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF1A1A1A),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(QS. Al-Baqarah: 125)',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF888888),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Makam Ibrahim terletak tidak jauh dari Ka\'bah dan menjadi bagian dari rangkaian ibadah setelah thowaf.',
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