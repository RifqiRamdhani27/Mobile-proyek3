import 'package:flutter/material.dart';
import 'package:flutter_application/isi_fiqih_umroh/ihram_miqot/larangan_saat_ihram.dart';
import 'package:flutter_application/isi_fiqih_umroh/ihram_miqot/niat_umroh.dart';
import 'package:flutter_application/isi_fiqih_umroh/ihram_miqot/penjelasan_ihram_miqot.dart';
import 'package:flutter_application/isi_fiqih_umroh/ihram_miqot/sunnah_ihram.dart';

class IhramMiqotScreen extends StatelessWidget {
  const IhramMiqotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      // ===== APP BAR =====
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        title: const Text(
          "Ihram di Miqot",
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
                      builder: (context) => const PenjelasanIhramMiqot(),
                    ),
                  );
                },
                child: _menuItem(
                  "Penjelasan Ihram di Miqot",
                  "assets/images/ihram_di_miqat.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NiatUmroh(),
                    ),
                  );
                },
                child: _menuItem("Niat Umroh", "assets/images/niat_umroh.png"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SunnahIhram(),
                    ),
                  );
                },
                child: _menuItem(
                  "Sunnah Saat Ihram",
                  "assets/images/sunnah_ihram.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LaranganSaatIhram(),
                    ),
                  );
                },
                child: _menuItem(
                  "Larangan Saat Ihram",
                  "assets/images/larangan.png",
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
