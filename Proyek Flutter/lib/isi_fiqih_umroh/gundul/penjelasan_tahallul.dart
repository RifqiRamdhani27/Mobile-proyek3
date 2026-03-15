import 'package:flutter/material.dart';

class PenjelasanTahallul extends StatelessWidget {
  const PenjelasanTahallul({super.key});

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
          "Penjelasan Tahallul",
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
                "Tahallul",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Tahallul adalah mencukur atau memotong rambut sebagai tanda selesainya rangkaian ibadah umroh atau sebagian rangkaian haji.

Tahallul dilakukan setelah selesai sa’i dalam umroh. Dengan tahallul, jamaah keluar dari keadaan ihram dan diperbolehkan kembali melakukan hal-hal yang sebelumnya dilarang saat ihram.

Allah berfirman dalam QS. Al-Fath ayat 27:""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 16),

              Center(
                child: Text(
                  "لَتَدْخُلُنَّ الْمَسْجِدَ الْحَرَامَ إِن شَاءَ اللَّهُ آمِنِينَ مُحَلِّقِينَ رُءُوسَكُمْ وَمُقَصِّرِينَ لَا تَخَافُونَ",
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Artinya:
"Sungguh, kamu pasti akan memasuki Masjidil Haram, insya Allah dalam keadaan aman, dengan mencukur rambut kepala dan memendekkannya, sedang kamu tidak merasa takut."

Ayat ini menjadi dalil bahwa mencukur atau memotong rambut adalah bagian dari syariat dalam ibadah haji dan umroh.

Ketentuan tahallul:

Laki-laki lebih utama menggundul rambut (halq).
Boleh juga memendekkan rambut (taqsir).
Perempuan cukup memotong sedikit ujung rambutnya.

Tahallul menandakan penyempurnaan ibadah dan ketaatan kepada Allah.""",
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
