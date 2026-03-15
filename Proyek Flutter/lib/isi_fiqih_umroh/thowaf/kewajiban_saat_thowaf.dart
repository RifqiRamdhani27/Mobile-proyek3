import 'package:flutter/material.dart';

class KewajibanSaatThowaf extends StatelessWidget {
  const KewajibanSaatThowaf({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),

      // ===== APPBAR =====
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Kewajiban Saat Thowaf",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),

      // ===== BODY =====
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 8),

              Text(
                "Syarat Sah Thowaf",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE6A63C),
                ),
              ),

              SizedBox(height: 16),

              Text(
                "Agar thowaf sah, ada beberapa hal yang wajib dipenuhi:",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 12),

              Text(
                """1.) Suci dari hadas dan najis
    Harus dalam keadaan berwudhu dan pakaian bersih dari najis.

2.) Menutup aurat
    Aurat wajib tertutup sesuai ketentuan syariat.

3.) Dilakukan di dalam Masjidil Haram
    Mengelilingi Ka’bah dari luar bangunan Ka’bah.

4.) Mengelilingi Ka’bah sebanyak 7 putaran sempurna
    Tidak boleh kurang.

5.) Memulai dari Hajar Aswad
    Dan berakhir di tempat yang sama.

6.) Menjadikan Ka’bah di sebelah kiri
    Artinya berputar berlawanan arah jarum jam.

7.) Dilakukan secara berurutan (tertib)
    Tidak boleh melompat-lompat putaran.""",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Jika salah satu kewajiban ini tidak terpenuhi, maka thowaf bisa tidak sah dan harus diulang.",
                style: TextStyle(
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),

      // ===== NAVBAR BAWAH =====
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFE6A63C),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: "Time"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Health"),
        ],
      ),
    );
  }
}
