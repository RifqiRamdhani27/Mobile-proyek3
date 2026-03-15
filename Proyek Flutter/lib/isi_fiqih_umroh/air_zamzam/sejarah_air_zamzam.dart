import 'package:flutter/material.dart';

class SejarahAirZamzam extends StatelessWidget {
  const SejarahAirZamzam({super.key});

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
          "Sejarah Air Zamzam",
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
                "Sejarah Air Zamzam",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Air Zamzam bermula dari kisah perjuangan Siti Hajar ketika mencari air untuk putranya, Nabi Ismail ‘alaihis salam, di padang pasir yang tandus.

Siti Hajar berlari antara bukit Shafa dan Marwah sebanyak tujuh kali demi mencari air. Atas pertolongan Allah, kemudian muncullah mata air dari hentakan kaki Nabi Ismail.

Peristiwa ini menjadi bagian dari sejarah besar dalam ibadah haji dan umroh, yang kemudian diabadikan dalam ibadah sa’i.

Allah berfirman dalam QS. Ibrahim ayat 37 tentang doa Nabi Ibrahim saat meninggalkan keluarganya di lembah yang tandus.

Air Zamzam menjadi bukti pertolongan Allah kepada hamba-Nya yang bertawakal.""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.5,
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
