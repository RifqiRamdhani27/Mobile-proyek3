import 'package:flutter/material.dart';

class KeutamaanAirZamzam extends StatelessWidget {
  const KeutamaanAirZamzam({super.key});

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
          "Keutamaan Air Zamzam",
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
                "Keutamaan dan Adab Minum Air Zamzam",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Center(
                child: Text(
                  "\"Air Zamzam sesuai dengan niat orang yang meminumnya.\" (HR. Ibnu Majah)",
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
                "Keutamaannya:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 12),

              Text(
                """• Air yang penuh keberkahan

• Bisa diminum dengan niat kebaikan

• Mengingatkan pada tawakal Siti Hajar""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Adab saat minum Air Zamzam:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 12),

              Text(
                """• Menghadap kiblat

• Membaca basmalah

• Minum tiga kali teguk

• Berdoa setelah minum""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Zamzam bukan sekadar air, tetapi simbol keimanan dan pertolongan Allah.",
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
