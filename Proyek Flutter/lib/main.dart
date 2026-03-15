import 'package:flutter/material.dart';
import 'Widgets/home_card.dart';
import 'Screens/persiapan_haji.dart';
import 'Screens/fiqih_umroh.dart';
import 'Screens/dzikir_doa.dart';
import 'Screens/tata_cara_haji.dart';
import 'Screens/tata_cara_umroh.dart';
import 'Screens/fiqih_haji.dart';
import 'Screens/peta_jarak.dart';
import 'Screens/lokasi_ziarah.dart';
import 'Hal/time.dart';
import 'Screens/AI/chatbot.dart';

void main() {
  runApp(const RavolaApp());
}

class RavolaApp extends StatelessWidget {
  const RavolaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF4B400),
        elevation: 0,
        toolbarHeight: 60,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            // ✅ semua HomeCard kamu BIARKAN — tidak perlu diubah
            HomeCard(
              title: "Persiapan Haji",
              imagePath: "assets/images/PersiapanHaji.jpg",
              bottomBarColor: Color.fromARGB(255, 57, 55, 55),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PersiapanHajiScreen(),
                  ),
                );
              },
            ),
            HomeCard(
              title: "Fiqih Umroh",
              imagePath: "assets/images/FiqihUmroh.jpg",
              bottomBarColor: Color.fromARGB(255, 57, 55, 55),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FiqihUmrohScreen(),
                  ),
                );
              },
            ),
            HomeCard(
              title: "Dzikir & Doa",
              imagePath: "assets/images/DzikirDoa.jpg",
              bottomBarColor: Color.fromARGB(255, 57, 55, 55),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DzikirDoaScreen(),
                  ),
                );
              },
            ),

            HomeCard(
              title: "Tata Cara Umroh",
              imagePath: "assets/images/TataCaraUmroh.jpg",
              bottomBarColor: Color.fromARGB(255, 57, 55, 55),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TataCaraUmrohScreen(),
                  ),
                );
              },
            ),
            HomeCard(
              title: "Tata Cara Haji",
              imagePath: "assets/images/TataCaraHaji.jpg",
              bottomBarColor: Color.fromARGB(255, 57, 55, 55),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TataCaraHajiScreen(),
                  ),
                );
              },
            ),
            HomeCard(
              title: "Peta Jarak",
              imagePath: "assets/images/PetaJarak.jpg",
              bottomBarColor: Color.fromARGB(255, 57, 55, 55),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PetaJarakScreen(),
                  ),
                );
              },
            ),
            HomeCard(
              title: "Lokasi Ziarah",
              imagePath: "assets/images/LokasiZiarah.jpg",
              bottomBarColor: Color.fromARGB(255, 57, 55, 55),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LokasiZiarahScreen(),
                  ),
                );
              },
            ),
            HomeCard(
              title: "Fiqih Haji",
              imagePath: "assets/images/FiqihHaji.jpg",
              bottomBarColor: Color.fromARGB(255, 57, 55, 55),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FiqihHajiScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // ====== CHATBOT ======
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatbotScreen()),
          );
        },
        child: Container( 
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset("assets/images/chatbot.png", fit: BoxFit.cover),
          ),
        ),
      ),

      // ====== Navigasi Bawah======
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        backgroundColor: const Color(0xFFE6A63C),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() => _navIndex = index);

          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TimeHal()),
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
}
