import 'package:flutter/material.dart';

class TeladanRasulullah extends StatelessWidget {
  const TeladanRasulullah({super.key});

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
          "Teladan Rasulullah",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Teladan Rasulullah dalam Haji",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Rasulullah ﷺ melaksanakan haji yang dikenal dengan Haji Wada’ (haji perpisahan). Dari beliau kita belajar tata cara dan adab berhaji.""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 16),

              Text(
                "QS. Al-Ahzab ayat 21:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "“Sungguh, telah ada pada (diri) Rasulullah itu suri teladan yang baik bagimu.”",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 6),

              Text(
                "(QS. Al-Ahzab: 21)",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),

              SizedBox(height: 18),

              Text(
                "Dalam berhaji, kita meneladani Rasulullah dengan:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              // ===== BULLET LIST =====
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• ",
                    style: TextStyle(fontFamily: 'TimesNewRoman', fontSize: 15),
                  ),
                  Expanded(
                    child: Text(
                      "Mengikuti tata cara sesuai sunnah",
                      style: TextStyle(
                        fontFamily: 'TimesNewRoman',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 6),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• ",
                    style: TextStyle(fontFamily: 'TimesNewRoman', fontSize: 15),
                  ),
                  Expanded(
                    child: Text(
                      "Bersikap lembut dan tidak menyakiti orang lain",
                      style: TextStyle(
                        fontFamily: 'TimesNewRoman',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 6),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "• ",
                    style: TextStyle(fontFamily: 'TimesNewRoman', fontSize: 15),
                  ),
                  Expanded(
                    child: Text(
                      "Memperbanyak dzikir dan doa",
                      style: TextStyle(
                        fontFamily: 'TimesNewRoman',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              Text(
                "Mencontoh Rasulullah membuat ibadah kita lebih sempurna.",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
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
