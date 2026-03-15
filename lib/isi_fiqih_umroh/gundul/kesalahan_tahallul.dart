import 'package:flutter/material.dart';

class KesalahanTahallul extends StatelessWidget {
  const KesalahanTahallul({super.key});

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
          "Kesalahan Saat Tahallul",
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
                "Kesalahan dalam Tahallul",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                """Beberapa kesalahan yang perlu dihindari:

1. Tidak mencukur atau memotong rambut sama sekali.
   Padahal tahallul termasuk bagian wajib dalam umroh.

2. Hanya memotong satu atau dua helai rambut.
   Yang benar adalah memotong secara merata, bukan simbolis saja.

3. Perempuan menggundul rambut.
   Bagi perempuan cukup memotong sedikit ujung rambut,
   tidak boleh mencukur habis.

4. Melakukan tahallul sebelum menyelesaikan sa’i.
   Urutan ibadah harus dijaga dengan benar.

Tahallul bukan sekadar potong rambut, tetapi simbol ketaatan dan penyempurnaan ibadah.""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.6,
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
