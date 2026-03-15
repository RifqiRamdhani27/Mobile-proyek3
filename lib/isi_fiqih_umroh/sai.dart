import 'package:flutter/material.dart';
import 'package:flutter_application/isi_fiqih_umroh/sai/kesalahan_sai.dart';
import 'package:flutter_application/isi_fiqih_umroh/sai/penjelasan_sai.dart';
import 'package:flutter_application/isi_fiqih_umroh/sai/sejarah_sai.dart';
import 'package:flutter_application/isi_fiqih_umroh/sai/sunnah_sai.dart';

class Sai extends StatelessWidget {
  const Sai({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      // ===== APP BAR =====
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        title: const Text(
          "Sa'i",
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
                    MaterialPageRoute(builder: (context) => const SejarahSai()),
                  );
                },
                child: _menuItem("Sejarah Sa'i", "assets/images/sejarah_sai.png"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PenjelasanSai(),
                    ),
                  );
                },
                child: _menuItem(
                  "Penjelasan Sa'i",
                  "assets/images/penjelasan_sai.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SunnahSai()),
                  );
                },
                child: _menuItem(
                  "Tata Cara & Sunnah Sa'i",
                  "assets/images/sunnah_sai.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KesalahanSai(),
                    ),
                  );
                },
                child: _menuItem(
                  "Hikmah & Kesalahan dalam Sa'i",
                  "assets/images/kesalahan_sa'i.png",
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
