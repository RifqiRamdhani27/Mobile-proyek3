import 'package:flutter/material.dart';

class TataCaraThowaf extends StatelessWidget {
  const TataCaraThowaf({super.key});

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
          "Tata Cara Thowaf",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 8),

              Text(
                "Urutan Pelaksanaan Thowaf",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                "Berikut urutan pelaksanaan thowaf:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 12),

              Text(
                """1.) Suci dari hadas (berwudhu)
2.) Menutup aurat
3.) Niat dalam hati
4.) Memulai dari Hajar Aswad
5.) Mengelilingi Ka’bah 7 putaran berlawanan arah jarum jam
6.) Membaca doa dan dzikir selama thowaf
7.) Setelah selesai, shalat 2 rakaat di belakang Makam Ibrahim (jika memungkinkan)""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Thowaf dilakukan dengan tertib, tidak mendorong, dan tetap menjaga adab.",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
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
