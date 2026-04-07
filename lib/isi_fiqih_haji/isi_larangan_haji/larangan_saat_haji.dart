import 'package:flutter/material.dart';

class LaranganSaatHajiScreen extends StatelessWidget {
  final bool isDark;
  const LaranganSaatHajiScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final List<String> larangan = [
      "Berkata kotor atau bertengkar",
      "Memotong rambut atau kuku (saat ihram)",
      "Memakai wangi-wangian (setelah niat ihram)",
      "Berburu hewan darat",
      "Menikah atau menikahkan",
    ];

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
                          'Larangan Saat Haji',
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
                    const Text(
                      "Larangan Saat Haji",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Saat dalam keadaan ihram dan menjalankan haji, ada larangan yang harus dijaga.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: textClr,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Allah berfirman dalam QS. Al-Baqarah ayat 197:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: textClr,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Arabic Text Box
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "فَلَا رَفَثَ وَلَا فُسُوقَ وَلَا جِدَالَ فِي الْحَجِّ",
                          style: TextStyle(
                            fontSize: 22,
                            height: 1.8,
                            color: textClr,
                            fontFamily: 'serif', // Optional: adjust for better Arabic font
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Translation Box
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '"Maka tidak boleh berkata kotor, berbuat fasik, dan berbantah-bantahan dalam haji."',
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF1A1A1A),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "(QS. Al-Baqarah: 197)",
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
                      "Beberapa larangan:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: textClr,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...larangan.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "• ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFE6A63C),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: textClr,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 16),
                    Text(
                      "Menjaga larangan ini adalah bagian dari kesempurnaan ibadah.",
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