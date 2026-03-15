import 'package:flutter/material.dart';

class MaknaJamaahHaji extends StatelessWidget {
  const MaknaJamaahHaji({super.key});

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
          "Makna Jamaah Haji",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),

      // ===== BODY =====
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 8),

              Text(
                "Tamu-Tamu Allah",
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
                """Setelah Nabi Ibrahim dan putranya Nabi Ismail ‘alaihimassalam selesai membangun Ka'bah, maka Allah memerintahkan Nabi Ibrahim untuk menyeru kepada manusia agar mereka datang melaksanakan ibadah haji.

Kenapa?, karena rumah Allah, Baitullah, telah dibangun. Tinggal mereka datang menuju Baitullah untuk berhaji. Allah Subḥānahu wa Ta'ālā berfirman:""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 16),

              // ===== AYAT ARAB =====
              Text(
                "وَأَذِّنْ فِي النَّاسِ بِالْحَجِّ يَأْتُوكَ رِجَالًا وَعَلَىٰ كُلِّ ضَامِرٍ يَأْتِينَ مِن كُلِّ فَجٍّ عَمِيقٍ",
                style: TextStyle(fontSize: 18, height: 1.6),
                textAlign: TextAlign.right,
              ),

              SizedBox(height: 12),

              Text(
                """"Dan berserulah kepada manusia untuk mengerjakan haji, niscaya mereka akan datang kepadamu dengan berjalan kaki dan mengendarai unta, yang datang dari segenap penjuru yang jauh." (Qs. Al Hajj ayat 27)""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
                  color: Colors.black87,
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
