import 'package:flutter/material.dart';

class MaknaJamaahHajiScreen extends StatelessWidget {
  final bool isDark;
  const MaknaJamaahHajiScreen({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);

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
                    Text(
                      'Makna Jamaah Haji',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFFC9A84C) : Colors.black,
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
                    const Center(
                      child: Text(
                        'Tamu-Tamu Allah',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE6A63C),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Setelah Nabi Ibrahim dan putranya Nabi Ismail \'alaihimassalam selesai '
                      'membangun Ka\'bah, maka Allah memerintahkan Nabi Ibrahim untuk menyeru '
                      'kepada manusia agar mereka datang melaksanakan ibadah haji.\n\n'
                      'Kenapa?, karena rumah Allah, Baitullah, telah dibangun. Tinggal mereka '
                      'datang menuju Baitullah untuk berhaji. Allah Subḥānahu wa Ta\'ālā berfirman:',
                      style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E7),
                        border: const Border(
                          left: BorderSide(color: Color(0xFFE6A63C), width: 4),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'وَأَذِّنْ فِي النَّاسِ بِالْحَجِّ يَأْتُوكَ رِجَالًا وَعَلَىٰ كُلِّ ضَامِرٍ يَأْتِينَ مِن كُلِّ فَجٍّ عَمِيقٍ',
                        style: TextStyle(
                          fontSize: 20,
                          height: 1.8,
                          color: Color(0xFF1A1A1A),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '"Dan berserulah kepada manusia untuk mengerjakan haji, niscaya mereka '
                      'akan datang kepadamu dengan berjalan kaki dan mengendarai unta, yang '
                      'datang dari segenap penjuru yang jauh." (Qs. Al Hajj ayat 27)',
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
      ),
    );
  }
}