import 'package:flutter/material.dart';

class PenjelasanIhramMiqotScreen extends StatelessWidget {
  final bool isDark;
  const PenjelasanIhramMiqotScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg        = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr   = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg  = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr  = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

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
                        'Penjelasan Ihram di Miqot',
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
                  const Text(
                    'Ihram di Miqot',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE6A63C),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ihram adalah niat untuk memulai ibadah umroh atau haji yang dilakukan di tempat yang telah ditentukan, yang disebut miqot.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: textClr,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Miqot adalah batas tempat seseorang harus sudah berniat ihram sebelum memasuki Makkah. Setiap wilayah memiliki miqot masing-masing.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: textClr,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ihram bukan hanya memakai pakaian putih, tetapi:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textClr,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...['Niat dalam hati', 'Mengucapkan talbiyah', 'Siap menaati aturan ihram']
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('• ', style: TextStyle(fontSize: 15, color: textClr)),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: TextStyle(fontSize: 15, color: textClr),
                                  ),
                                ),
                              ],
                            ),
                          )),
                  const SizedBox(height: 4),
                  Text(
                    'Allah SWT berfirman dalam QS. Al-Baqarah ayat 196:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textClr,
                    ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '"Dan sempurnakanlah ibadah haji dan umrah karena Allah."',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF1A1A1A),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(QS. Al-Baqarah: 196)',
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
                    'Ihram menandakan bahwa kita mulai masuk dalam keadaan ibadah yang suci dan penuh ketaatan.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: textClr,
                    ),
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