import 'package:flutter/material.dart';

class IsiKeutamaanHajiScreen extends StatelessWidget {
  const IsiKeutamaanHajiScreen({super.key});

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
          "Keutamaan Haji",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),

      // ===== BODY =====
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            SizedBox(height: 8),

            Text(
              "Keutamaan Haji",
              style: TextStyle(
                fontFamily: 'TimesNewRoman',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE6A63C),
              ),
            ),

            SizedBox(height: 16),

            Text(
              """Tidak ada yang ragu bahwasanya haji merupakan ibadah yang dirindukan oleh setiap muslim di atas muka bumi ini, yang kalau kita mendengar cerita tentang bagaimana kerinduan kaum muslimin terhadap ibadah haji sungguh sangat luar biasa.

Mulai orang-orang yang mengumpulkan uang bertahun-tahun bahkan puluhan tahun agar bisa berangkat ke tanah suci untuk melaksanakan ibadah.

Kita dengar juga cerita ada sebagian wanita Indonesia yang tatkala sampai di Saudi mereka langsung sujud syukur, begitu luar biasa bahkan banyak yang bercita-cita ingin meninggal tatkala haji, ingin meninggal di tanah suci dan terlalu banyak cerita yang menjelaskan tentang bagaimana luar biasanya kerinduan kaum Muslimin terhadap ibadah haji.""",
              style: TextStyle(
                fontFamily: 'TimesNewRoman',
                fontSize: 15,
                height: 1.25,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
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
