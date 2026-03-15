import 'package:flutter/material.dart';

class IkhlasBerhaji extends StatelessWidget {
  const IkhlasBerhaji({super.key});

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
          "Ikhlas Berhaji",
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
                "Ikhlas dalam Berhaji",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Haji harus dilandasi niat yang ikhlas karena Allah, bukan untuk gelar, pujian, atau kebanggaan.""",
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
                "QS. Al-Bayyinah ayat 5:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "“Padahal mereka hanya diperintah menyembah Allah dengan ikhlas menaati-Nya dalam menjalankan agama.”",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.35,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 6),

              Text(
                "(QS. Al-Bayyinah: 5)",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),

              SizedBox(height: 18),

              Text(
                "Ikhlas berarti:",
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
                      "Berhaji hanya mengharap ridha Allah",
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
                      "Tidak riya (ingin dipuji)",
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
                      "Tidak membanggakan diri setelah pulang haji",
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
                """Ibadah yang ikhlas akan melahirkan haji yang mabrur dan perubahan diri yang lebih baik.""",
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
