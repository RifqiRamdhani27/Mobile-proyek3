import 'package:flutter/material.dart';

class SabarSaatHaji extends StatelessWidget {
  const SabarSaatHaji({super.key});

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
          "Sabar Saat Haji",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
      ),

// ===== BODY =====
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Kesabaran dalam Ibadah Haji",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Ibadah haji adalah perjalanan penuh ujian. Banyaknya jamaah dari berbagai negara, cuaca yang panas, serta rangkaian ibadah yang padat membutuhkan kesabaran yang besar.""",
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
                "QS. Al-Baqarah ayat 153:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "“Wahai orang-orang yang beriman! Mohonlah pertolongan (kepada Allah) dengan sabar dan shalat. Sesungguhnya Allah beserta orang-orang yang sabar.”",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 6),

              Text(
                "(QS. Al-Baqarah: 153)",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),

              SizedBox(height: 18),

              Text(
                "Saat berhaji, kita belajar:",
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
                      "Sabar dalam antrian",
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
                      "Sabar menghadapi perbedaan",
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
                      "Sabar dalam kelelahan fisik",
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
                      "Sabar menjaga emosi",
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
                "Dengan kesabaran, ibadah menjadi lebih tenang dan bernilai di sisi Allah.",
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
