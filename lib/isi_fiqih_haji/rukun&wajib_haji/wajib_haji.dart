import 'package:flutter/material.dart';

class WajibHaji extends StatelessWidget {
  const WajibHaji({super.key});

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
          "Wajib Haji",
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
                "Wajib Haji",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Wajib haji adalah amalan yang harus dilakukan. Jika ditinggalkan, hajinya tetap sah tetapi wajib membayar dam (denda).

Wajib haji antara lain:

1. Ihram dari miqot
2. Mabit (bermalam) di Muzdalifah
3. Mabit di Mina
4. Melontar jumrah
5. Thawaf Wada’

Berbeda dengan rukun, wajib haji bisa diganti dengan dam jika terlewat.""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.7,
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
