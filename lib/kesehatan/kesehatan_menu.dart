import 'package:flutter/material.dart';
import '../main.dart'; // 🔥 ambil Dock + themeNotifier dari main

class KesehatanMenu extends StatelessWidget {
  const KesehatanMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: themeNotifier,
      builder: (context, isDark, _) {
        final bgColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F2);

        return Scaffold(
          backgroundColor: bgColor,

          // ===== HEADER =====
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFC107),
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Health",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // ===== BODY =====
          body: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              menuItem("Faktor Risiko Kesehatan Jamaah Haji", Icons.thermostat),
              menuItem("Regulasi Kesehatan Calon Jamaah Haji Indonesia",
                  Icons.article),
              menuItem(
                  "Kondisi Klinis yang Tidak Memenuhi syarat istithaah Kesehatan",
                  Icons.monitor_heart),
              menuItem("Optimalisasi Status Kesehatan Jamaah",
                  Icons.medical_services),
              menuItem("Panduan Menjaga Kesehatan selama ibadah haji",
                  Icons.favorite),
              menuItem("Pemantauan Kesehatan Pasca Kepulangan",
                  Icons.home_repair_service),
              menuItem("Tips Kesehatan Selama di Tanah Suci",
                  Icons.lightbulb),
              menuItem("Rekomendasi Konsumsi Buah dan Sayur",
                  Icons.apple),
              menuItem("Panduan Kesehatan jamaah Haid",
                  Icons.bloodtype),
              menuItem("Sumber Dan Reserensi",
                  Icons.menu_book),
            ],
          ),

          // ===== DOCK (PAKAI PUNYA KAMU) =====
          bottomNavigationBar: Dock(
            isDark: isDark,
            activeLabel: 'Health',
          ),
        );
      },
    );
  }

  // ===== CARD MENU =====
  Widget menuItem(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            // nanti bisa isi navigasi ke detail
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, size: 30, color: Colors.grey[700]),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}