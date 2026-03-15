import 'package:flutter/material.dart';

class MotivasiBerhaji extends StatelessWidget {
  const MotivasiBerhaji({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),

      // ===== APPBAR =====
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Motivasi Berhaji",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Motivasi Haji",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16),

              Text(
                """Haji adalah panggilan istimewa dari Allah Subhānahu wa Ta‘ālā kepada hamba-Nya yang mampu. Perintah haji secara langsung disebutkan dalam Al-Qur’an.""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 16),

              Text(
                "QS. Ali ‘Imran ayat 97:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "“Mengerjakan haji adalah kewajiban manusia terhadap Allah, yaitu bagi orang yang mampu mengadakan perjalanan ke Baitullah. Barang siapa mengingkari (kewajiban haji), maka sesungguhnya Allah Maha Kaya (tidak memerlukan sesuatu) dari semesta alam.”",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 6),

              Text(
                "(QS. Ali ‘Imran: 97)",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),

              SizedBox(height: 16),

              Text(
                "QS. Al-Hajj ayat 27:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "“Dan berserulah kepada manusia untuk mengerjakan haji, niscaya mereka akan datang kepadamu dengan berjalan kaki dan mengendarai unta, yang datang dari segenap penjuru yang jauh.”",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 6),

              Text(
                "(QS. Al-Hajj: 27)",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Dari ayat-ayat tersebut, kita memahami bahwa haji adalah kewajiban bagi yang mampu dan merupakan panggilan Allah kepada seluruh manusia. Motivasi terbesar dalam berhaji adalah untuk meraih ridha Allah, menghapus dosa, serta menjadi pribadi yang lebih baik setelah kembali dari tanah suci.

Semoga Allah memudahkan kita untuk memenuhi panggilan-Nya dan mendapatkan haji yang mabrur. Aamiin.""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // ===== NAVBAR BAWAH =====
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFE6A63C),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: "Time"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Health"),
        ],
      ),
    );
  }
}
