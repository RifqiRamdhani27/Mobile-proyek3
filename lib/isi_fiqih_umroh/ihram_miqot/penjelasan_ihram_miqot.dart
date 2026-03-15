import 'package:flutter/material.dart';

class PenjelasanIhramMiqot extends StatelessWidget {
  const PenjelasanIhramMiqot({super.key});

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
          "Penjelasan Ihram di Miqot",
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
                "Ihram di Miqot",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Ihram adalah niat untuk memulai ibadah umroh atau haji yang dilakukan di tempat yang telah ditentukan, yang disebut miqot.

Miqot adalah batas tempat seseorang harus sudah berniat ihram sebelum memasuki Makkah. Setiap wilayah memiliki miqot masing-masing.

Ihram bukan hanya memakai pakaian putih, tetapi:

• Niat dalam hati
• Mengucapkan talbiyah
• Siap menaati aturan ihram

Allah SWT berfirman dalam QS. Al-Baqarah ayat 196:

"Dan sempurnakanlah ibadah haji dan umrah karena Allah."

Ihram menandakan bahwa kita mulai masuk dalam keadaan ibadah yang suci dan penuh ketaatan.""",
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
