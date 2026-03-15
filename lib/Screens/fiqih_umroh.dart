import 'package:flutter/material.dart';
import 'package:flutter_application/isi_fiqih_umroh/ihram_miqot.dart';
import 'package:flutter_application/isi_fiqih_umroh/minum_air_zamzam.dart';
import 'package:flutter_application/isi_fiqih_umroh/thowaf.dart';
import 'package:flutter_application/isi_fiqih_umroh/makam_ibrahim.dart';
import 'package:flutter_application/isi_fiqih_umroh/minum_air_zamzam.dart';
import 'package:flutter_application/isi_fiqih_umroh/sai.dart';
import 'package:flutter_application/isi_fiqih_umroh/gundul.dart';

class FiqihUmrohScreen extends StatelessWidget {
  const FiqihUmrohScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      // ===== APP BAR =====
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        title: const Text(
          "Fiqih Umroh",
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
                      builder: (context) => const IhramMiqotScreen(),
                    ),
                  );
                },
                child: _menuItem(
                  "Ihram Miqot",
                  "assets/images/ihram_miqot.png",
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Thowaf()),
                  );
                },
                child: _menuItem("Thowaf", "assets/images/thowaf.png"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MakamIbrahim(),
                    ),
                  );
                },
                child: _menuItem("Makam Ibrahim", "assets/images/makam_ibrahim.png"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MinumAirZamzam(),
                    ),
                  );
                },
                child: _menuItem("Minum Air Zamzam", "assets/images/minum_air_zamzam.png"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Sai(),
                    ),
                  );
                },
                child: _menuItem("Sa'i", "assets/images/sa'i2.png"),
              ),
GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Gundul(),
                    ),
                  );
                },
                child: _menuItem("Gundul / Cukuran Umroh / Haji", "assets/images/gundul.png"),
              ),            ],
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
