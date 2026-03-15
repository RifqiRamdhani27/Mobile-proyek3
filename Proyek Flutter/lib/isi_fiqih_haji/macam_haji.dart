import 'package:flutter/material.dart';
import 'package:flutter_application/isi_fiqih_haji/macam2haji/macam_macam_haji.dart';
import 'package:flutter_application/isi_fiqih_haji/macam2haji/mengikuti_urutan.dart';
import 'package:flutter_application/isi_fiqih_haji/macam2haji/perbedan_jenis_jenis_haji.dart';
import 'package:flutter_application/isi_fiqih_haji/macam2haji/urutan_umum.dart';

class MacamHaji extends StatelessWidget {
  const MacamHaji({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      // ===== APP BAR =====
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        title: const Text(
          "Macam Haji & Urutannya",
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
                    MaterialPageRoute(builder: (context) => const MacamMacamHaji()),
                  );
                },
                child: _menuItem("Macam-Macam Haji", "assets/images/hukum.png"),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PerbedanJenisJenisHaji(),
                    ),
                  );
                },
                child: _menuItem("Perbedaan Haji Ifrad, Qiran, dan Tamattu", "assets/images/syarat.png"),
              ),
                            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UrutanUmumHaji(),
                    ),
                  );
                },
                child: _menuItem("Urutan Umum Perjalanan Haji", "assets/images/syarat.png"),
              ),
                            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MengikutiUrutan(),
                    ),
                  );
                },
                child: _menuItem("Mengikuti Urutan Dengan Benar", "assets/images/syarat.png"),
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
