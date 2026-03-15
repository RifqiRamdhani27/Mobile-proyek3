import 'package:flutter/material.dart';

class JagaHajiAgarMabrur extends StatelessWidget {
  const JagaHajiAgarMabrur({super.key});

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
          "Jaga Haji Agar Mabrur",
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
                "Haji Mabrur",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Haji mabrur adalah haji yang diterima oleh Allah dan membawa perubahan kebaikan dalam hidup seseorang.""",
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
                "Hadits:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "“Haji mabrur tidak ada balasan baginya kecuali surga.”",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 6),

              Text(
                "(HR. Bukhari dan Muslim)",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),

              SizedBox(height: 18),

              Text(
                "Agar haji mabrur:",
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
                      "Jaga lisan dari berkata kasar",
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
                      "Hindari pertengkaran",
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
                      "Perbanyak amal kebaikan",
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
                      "Istiqamah setelah pulang haji",
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
                """Haji bukan akhir perjalanan, tetapi awal menjadi pribadi yang lebih taat dan lebih baik.""",
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
