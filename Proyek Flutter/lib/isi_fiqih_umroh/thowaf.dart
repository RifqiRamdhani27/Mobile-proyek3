import 'package:flutter/material.dart';
import 'package:flutter_application/isi_fiqih_umroh/thowaf/kewajiban_saat_thowaf.dart';
import 'package:flutter_application/isi_fiqih_umroh/thowaf/larangan_saat_thowaf.dart';
import 'package:flutter_application/isi_fiqih_umroh/thowaf/macam_macam_thowaf.dart';
import 'package:flutter_application/isi_fiqih_umroh/thowaf/penjelasan_thowaf.dart';
import 'package:flutter_application/isi_fiqih_umroh/thowaf/sunnah_saat_thowaf.dart';
import 'package:flutter_application/isi_fiqih_umroh/thowaf/tata_cara_thowaf.dart';

class Thowaf extends StatelessWidget {
  const Thowaf({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      // ===== APP BAR =====
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        title: const Text(
          "Thowaf",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      // ===== BODY =====
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PenjelasanThowaf(),
                    ),
                  );
                },
                child: _menuItem(
                  "Penjelasan Thowaf",
                  "assets/images/thowaf.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TataCaraThowaf(),
                    ),
                  );
                },
                child: _menuItem(
                  "Tata Cara Thowaf",
                  "assets/images/niat_umroh.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KewajibanSaatThowaf(),
                    ),
                  );
                },
                child: _menuItem(
                  "Kewajiban Saat Thowaf",
                  "assets/images/sunnah_ihram.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LaranganSaatThowaf(),
                    ),
                  );
                },
                child: _menuItem(
                  "Larangan Saat Thowaf",
                  "assets/images/larangan.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SunnahSaatThowaf(),
                    ),
                  );
                },
                child: _menuItem(
                  "Sunnah Saat Thowaf",
                  "assets/images/sujud.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MacamMacamThowaf(),
                    ),
                  );
                },
                child: _menuItem(
                  "Macam MacamThowaf",
                  "assets/images/macam_thowaf.png",
                ),
              ),
            ],
          ),
        ),
      ),

      // ===== NAVBAR BAWAH (FIXED) =====
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE6A63C),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: "Time"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Health"),
        ],
      ),
    );
  }

  Widget _menuItem(String title, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 40, height: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
