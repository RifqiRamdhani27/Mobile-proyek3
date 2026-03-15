import 'package:flutter/material.dart';

class UrutanUmumHaji extends StatelessWidget {
  const UrutanUmumHaji({super.key});

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
          "",
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
                        image: AssetImage("assets/images/rute_ibadah_haji.png"),
                        fit: BoxFit.cover,
                        height: 320,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // ===== JUDUL =====
              Center(
                child: Text(
                  "Rute Ibadah Haji (Tamattu')",
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
                """1. Ihram dari miqot
2. Tawaf Qudum & Sa’i
3. Mabit di Mina
4. Wukuf di Arafah (9 Dzulhijah)
5. Mabit di Muzdalifah
6. Melempar Jumrah
7. Tahallul (cukur rambut)
8. Jumrah Aqabah
9. Tawaf Wada’ (tawaf perpisahan)
10. Kembali ke tanah air""",
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
