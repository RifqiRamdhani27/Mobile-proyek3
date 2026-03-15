import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class TimeHal extends StatefulWidget {
  const TimeHal({super.key});

  @override
  State<TimeHal> createState() => _TimeHalState();
}

class _TimeHalState extends State<TimeHal> {
  String currentTime = "";
  Timer? timer;
  int _navIndex = 2;

  // ===== JADWAL SHOLAT =====
  final Map<String, String> jadwal = {
    "Shubuh": "04:37",
    "Dzuhur": "11:59",
    "Ashar": "15:13",
    "Maghrib": "18:01",
    "Isya": "19:11",
  };

  @override
  void initState() {
    super.initState();
    _startClock();
  }

  void _startClock() {
    _updateTime();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      currentTime = DateFormat('HH:mm').format(now);
    });
  }

  // ===== CARI SHOLAT AKTIF =====
  String getSholatAktif() {
    final now = DateTime.now();
    final current = now.hour * 60 + now.minute;

    String aktif = "Isya";

    jadwal.forEach((nama, waktu) {
      final p = waktu.split(":");
      final menit = int.parse(p[0]) * 60 + int.parse(p[1]);
      if (current >= menit) aktif = nama;
    });

    return aktif;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        toolbarHeight: 60,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ===== CARD ATAS =====
            _imageCard(
              height: 210,
              image: "assets/images/time.png",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Assalamu’alaikum!",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13)),

                  const Text("Selamat Datang",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),

                  const Spacer(),

                  Text(currentTime,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold)),

                  Text(
                    getSholatAktif(),
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== CARD JADWAL =====
            _imageCardAuto(
              image: "assets/images/time.png",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Waktu Shalat",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),

                  const SizedBox(height: 18),

                  ...jadwal.entries.map(
                    (e) => _shalatRow(e.key, e.value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ===== NAVBAR =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        backgroundColor: const Color(0xFFE6A63C),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          if (index == _navIndex) return;
          setState(() => _navIndex = index);

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: "Time"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Health"),
        ],
      ),
    );
  }

  // ================= HELPER =================

  Widget _imageCard({
    required double height,
    required String image,
    required Widget child,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: _bg(image),
      child: _overlay(child),
    );
  }

  Widget _imageCardAuto({
    required String image,
    required Widget child,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      padding: const EdgeInsets.all(16),
      decoration: _bg(image),
      child: _overlay(child),
    );
  }

  BoxDecoration _bg(String image) => BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      );

  Widget _overlay(Widget child) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.black.withOpacity(0.35),
        ),
        padding: const EdgeInsets.all(18),
        child: child,
      );

  Widget _shalatRow(String name, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white70),
        color: Colors.white.withOpacity(0.12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15)),
          Text(time,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
