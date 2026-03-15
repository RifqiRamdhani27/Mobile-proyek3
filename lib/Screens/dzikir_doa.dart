import 'package:flutter/material.dart';

class DzikirDoaScreen extends StatelessWidget {
  const DzikirDoaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      // ===== APP BAR =====
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        title: const Text(
          "Dzikir & Doa",
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
              _menuItem("Dzikir Haji & Umroh", "assets/images/dzikir_haji_umroh.png"),
              _menuItem("Dzikir Pagi & Petang", "assets/images/dzikir_pagi_petang.png"),
              _menuItem("Dzikir & Do'a Kesehatan", "assets/images/dzikir_kesehatan.png"),
              _menuItem("Do'a Umum", "assets/images/doa_umum.png"),
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
