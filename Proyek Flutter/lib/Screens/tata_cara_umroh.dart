import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TataCaraUmrohScreen extends StatelessWidget {
  const TataCaraUmrohScreen({super.key});

  final String youtubeUrl =
      "https://www.youtube.com/watch?v=VIDEO_ID_KAMU"; // GANTI LINK

  Future<void> _launchYoutube() async {
    final Uri url = Uri.parse(youtubeUrl);

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Tidak bisa membuka YouTube');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),

      // ===== APP BAR =====
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        title: const Text(
          "Tata Cara Umroh",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      // ===== BODY =====
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 25),

            // ===== THUMBNAIL =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
              child: Container(
                height: 170, // Atur tinggi di sini
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  child: Image.asset(
                    "assets/images/tata_cara_umroh.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ===== TOMBOL =====
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE6A63C),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                elevation: 8,
              ),
              onPressed: _launchYoutube,
              child: const Text(
                "Tonton Video",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      // ===== NAVBAR BAWAH =====
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
}
