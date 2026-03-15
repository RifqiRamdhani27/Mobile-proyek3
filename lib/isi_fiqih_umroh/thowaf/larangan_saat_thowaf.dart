import 'package:flutter/material.dart';

class LaranganSaatThowaf extends StatelessWidget {
  const LaranganSaatThowaf({super.key});

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
          "Larangan Saat Thowaf",
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
                "Larangan Saat Thowaf",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                "Agar ibadah tetap sah dan bernilai, ada beberapa hal yang harus dihindari saat thowaf:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 12),

              Text(
                """• Bertengkar atau berkata kasar
  Allah berfirman dalam QS. Al-Baqarah ayat 197:
  "Tidak boleh rafats (berkata kotor), berbuat fasik, dan berbantah-bantahan dalam haji."

• Menyakiti atau mendorong jamaah lain
  Tidak boleh berebut hingga melukai orang lain.

• Melakukan perbuatan maksiat
  Seperti berkata kotor, berteriak-teriak tanpa alasan, atau bercanda berlebihan.

• Keluar dari area thowaf tanpa alasan syar’i
  Sehingga putaran menjadi terputus.

• Tidak menjaga kekhusyukan
  Terlalu sibuk foto, bercanda, atau berbicara hal duniawi berlebihan.""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Thowaf adalah ibadah yang agung, maka harus dilakukan dengan tenang, tertib, dan penuh rasa hormat kepada Allah.",
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
