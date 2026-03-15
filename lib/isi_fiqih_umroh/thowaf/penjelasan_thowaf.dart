import 'package:flutter/material.dart';

class PenjelasanThowaf extends StatelessWidget {
  const PenjelasanThowaf({super.key});

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
          "Penjelasan Thowaf",
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
                "Thowaf",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Thowaf adalah mengelilingi Ka’bah sebanyak 7 kali putaran, dimulai dari Hajar Aswad dan berakhir di tempat yang sama.

Thowaf termasuk rukun dalam umroh dan haji, sehingga tidak boleh ditinggalkan.

Allah berfirman dalam QS. Al-Hajj ayat 29:""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 16),

              Center(
                child: Text(
                  "\"Dan hendaklah mereka melakukan thawaf sekeliling rumah yang tua itu (Baitullah).\"",
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
                "Thowaf melambangkan kepatuhan dan ketundukan seorang hamba kepada Allah.",
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
