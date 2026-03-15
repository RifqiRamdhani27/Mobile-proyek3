import 'package:flutter/material.dart';

class SejarahSai extends StatelessWidget {
  const SejarahSai({super.key});

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
          "Sejarah Sa'I",
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
                "Sejarah Ibadah Sa’i",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Sa’i bermula dari kisah Siti Hajar, istri Nabi Ibrahim ‘alaihis salam, ketika mencari air untuk putranya Nabi Ismail di lembah yang tandus.

Beliau berlari antara bukit Shafa dan Marwah sebanyak tujuh kali karena melihat anaknya kehausan. Atas pertolongan Allah, muncullah air Zamzam dari dekat kaki Nabi Ismail.

Peristiwa ini kemudian dijadikan bagian dari ibadah haji dan umroh.

Allah berfirman dalam QS. Al-Baqarah ayat 158:""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 16),

              Center(
                child: Text(
                  "\"Sesungguhnya Shafa dan Marwah adalah sebagian dari syiar Allah.\"",
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Sa’i mengingatkan kita pada perjuangan, kesabaran, dan tawakal Siti Hajar.",
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
