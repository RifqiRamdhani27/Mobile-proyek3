import 'package:flutter/material.dart';
import 'package:flutter_application/isi_fiqih_haji/macam_haji.dart';
import 'package:flutter_application/isi_fiqih_haji/pengertian_haji.dart';
import 'package:flutter_application/isi_fiqih_haji/rukun&wajib_haji.dart';

class FiqihHajiScreen extends StatelessWidget {
  const FiqihHajiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      // ===== APP BAR =====
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        title: const Text(
          "Fiqih Haji",
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
                      builder: (context) => const PengertianHaji(),
                    ),
                  );
                },
                child: _menuItem(
                  "Pengertian, Hukum & Syarat Haji",
                  "assets/images/haji_tamattu.png",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RukunWajibHaji(),
                    ),
                  );
                },
                child: _menuItem(
                  "Rukun & Wajib Haji",
                  "assets/images/haji_ifrod.png",
                ),
              ),
GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MacamHaji
                      (),
                    ),
                  );
                },
                child: _menuItem(
                  "Macam Haji dan Urutannya",
                  "assets/images/haji_qiron.png",
                ),
              ),              _menuItem("Larangan, Hikmah & Keutamaan Haji", "assets/images/pelaksanaan_haji.png"),
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
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
