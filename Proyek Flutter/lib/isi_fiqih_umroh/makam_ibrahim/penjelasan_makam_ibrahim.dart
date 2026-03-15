import 'package:flutter/material.dart';

class PenjelasanMakamIbrahim extends StatelessWidget {
  const PenjelasanMakamIbrahim({super.key});

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
          "Penjelasan Makam Ibrahim",
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

              // ===== GAMBAR =====
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Image(
                        image: AssetImage("assets/images/makam_ibrahim2.png"),
                        fit: BoxFit.cover,
                        height: 160,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // ===== JUDUL =====
              Center(
                child: Text(
                  "Makam Ibrahim",
                  style: TextStyle(
                    fontFamily: 'TimesNewRoman',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE6A63C),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // ===== ISI =====
              Text(
                """Makam Ibrahim adalah batu tempat berdirinya Nabi Ibrahim ‘alaihis salam ketika membangun Ka’bah bersama putranya, Nabi Ismail.

Di atas batu tersebut terdapat bekas telapak kaki Nabi Ibrahim sebagai tanda sejarah yang dijaga hingga sekarang.

Allah SWT berfirman dalam QS. Al-Baqarah ayat 125:""",
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
                  "\"Dan jadikanlah sebagian Maqam Ibrahim sebagai tempat shalat.\"",
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
                "Makam Ibrahim terletak tidak jauh dari Ka’bah dan menjadi bagian dari rangkaian ibadah setelah thowaf.",
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
