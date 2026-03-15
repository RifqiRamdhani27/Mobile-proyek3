import 'package:flutter/material.dart';

class MacamMacamHaji extends StatelessWidget {
  const MacamMacamHaji({super.key});

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
          "Macam-Macam Haji",
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
          "Jenis-Jenis Haji",
          style: TextStyle(
            fontFamily: 'TimesNewRoman',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE6A63C),
          ),
        ),

        SizedBox(height: 16),

        Text(
          """Dalam pelaksanaannya, haji terbagi menjadi 3 jenis:

1. Haji Ifrad
Melaksanakan haji saja tanpa umroh.

2. Haji Qiran
   Melaksanakan haji dan umroh dalam satu niat sekaligus.

3. Haji Tamattu’
   Melaksanakan umroh terlebih dahulu, kemudian haji dalam satu musim haji dengan dua niat terpisah.

Ketiga jenis ini sah, tinggal memilih sesuai kondisi dan kemampuan jamaah.""",
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
