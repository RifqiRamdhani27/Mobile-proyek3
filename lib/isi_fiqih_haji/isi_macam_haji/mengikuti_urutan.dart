import 'package:flutter/material.dart';

class MengikutiUrutanScreen extends StatelessWidget {
  final bool isDark;
  const MengikutiUrutanScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: bg,
        body: Column(
          children: [
            // AppBar
            Container(
              height: 95,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: appBarBg,
              child: SafeArea(
                bottom: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
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
                          'Mengikuti Urutan Haji',
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
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pelaksanaan haji harus sesuai tuntunan Rasulullah ﷺ. Beliau bersabda:",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: textClr,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    // Ayat/Hadits Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E7),
                        borderRadius: BorderRadius.circular(8),
                        border: const Border(
                          left: BorderSide(color: Color(0xFFE6A63C), width: 4),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '"Ambillah dariku manasik haji kalian."',
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF1A1A1A),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "(HR. Muslim)",
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
                      "Artinya, kita harus mengikuti tata cara yang diajarkan Nabi agar haji sah dan sempurna.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: textClr,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Memahami jenis haji dan urutannya membantu jamaah menjalankan ibadah dengan tertib dan tenang.",
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
      ),
    );
  }
}