import 'package:flutter/material.dart';

class MotivasiBerhajiScreen extends StatelessWidget {
  final bool isDark;
  const MotivasiBerhajiScreen({super.key, required this.isDark});

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
                      'Motivasi Berhaji',
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
                    const Text(
                      'Motivasi Haji',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE6A63C),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Haji adalah panggilan istimewa dari Allah Subhānahu wa Ta\'ālā kepada hamba-Nya yang mampu. Perintah haji secara langsung disebutkan dalam Al-Qur\'an.',
                      style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'QS. Ali \'Imran ayat 97:',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                    ),
                    const SizedBox(height: 8),
                    _ayatBox(
                      '"Mengerjakan haji adalah kewajiban manusia terhadap Allah, yaitu bagi orang yang mampu mengadakan perjalanan ke Baitullah. Barang siapa mengingkari (kewajiban haji), maka sesungguhnya Allah Maha Kaya (tidak memerlukan sesuatu) dari semesta alam."',
                      '(QS. Ali \'Imran: 97)',
                    ),
                    Text(
                      'QS. Al-Hajj ayat 27:',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr),
                    ),
                    const SizedBox(height: 8),
                    _ayatBox(
                      '"Dan berserulah kepada manusia untuk mengerjakan haji, niscaya mereka akan datang kepadamu dengan berjalan kaki dan mengendarai unta, yang datang dari segenap penjuru yang jauh."',
                      '(QS. Al-Hajj: 27)',
                    ),
                    Text(
                      'Dari ayat-ayat tersebut, kita memahami bahwa haji adalah kewajiban bagi yang mampu dan merupakan panggilan Allah kepada seluruh manusia. Motivasi terbesar dalam berhaji adalah untuk meraih ridha Allah, menghapus dosa, serta menjadi pribadi yang lebih baik setelah kembali dari tanah suci.\n\n'
                      'Semoga Allah memudahkan kita untuk memenuhi panggilan-Nya dan mendapatkan haji yang mabrur. Aamiin.',
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

  Widget _ayatBox(String text, String source) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        border: const Border(
          left: BorderSide(color: Color(0xFFE6A63C), width: 4),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF1A1A1A)),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 8),
          Text(
            source,
            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Color(0xFF888888)),
          ),
        ],
      ),
    );
  }
}