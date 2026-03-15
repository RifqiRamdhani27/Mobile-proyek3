import 'package:flutter/material.dart';
import 'package:flutter_application/isi_persiapan_haji/keutamaan_haji.dart';
import 'package:flutter_application/isi_persiapan_haji/makna_jamaah_haji.dart';
import 'package:flutter_application/isi_persiapan_haji/motivasi_berhaji.dart';
import 'package:flutter_application/isi_persiapan_haji/sabar_saat_haji.dart';
import 'package:flutter_application/isi_persiapan_haji/ikhlas_berhaji.dart';
import 'package:flutter_application/isi_persiapan_haji/teladan_rasulullah.dart';
import 'package:flutter_application/isi_persiapan_haji/jaga_haji_agar_mabrur.dart';

class PersiapanHajiScreen extends StatelessWidget {
  const PersiapanHajiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      // ===== APP BAR =====
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        title: const Text(
          "Persiapan Haji",
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
              _menuItem(
                context,
                "Keutamaan Haji",
                "assets/images/keutamaan_haji.png",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const IsiKeutamaanHajiScreen(),
                    ),
                  );
                },
              ),

              _menuItem(
                context,
                "Makna Jamaah Haji",
                "assets/images/makna_jemaah_haji.png",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MaknaJamaahHaji(),
                    ),
                  );
                },
              ),
              _menuItem(
                context,
                "Motivasi Berhaji",
                "assets/images/motivasi_berhaji.png",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MotivasiBerhaji(),
                    ),
                  );
                },
              ),
              _menuItem(
                context,
                "Sabar Saat Haji",
                "assets/images/sabar_saat_haji.png",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SabarSaatHaji(),
                    ),
                  );
                },
              ),
              _menuItem(
                context,
                "Ikhlas Berhaji",
                "assets/images/ikhlas_berhaji.png",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const IkhlasBerhaji(),
                    ),
                  );
                },
              ),
              _menuItem(
                context,
                "Teladan Rasulullah",
                "assets/images/teladan_rasulullah.png",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TeladanRasulullah(),
                    ),
                  );
                },
              ),
              _menuItem(
                context,
                "Jaga Haji agar Mabrur",
                "assets/images/jaga_haji_agar_mabrur.png",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const JagaHajiAgarMabrur(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // ===== NAVBAR =====
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

  // ===== MENU ITEM =====
  Widget _menuItem(
    BuildContext context,
    String title,
    String imagePath, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
