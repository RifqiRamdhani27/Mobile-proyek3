import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'Screens/persiapan_haji.dart';
import 'Screens/fiqih_umroh.dart';
import 'Screens/dzikir_doa.dart';
import 'Screens/tata_cara_umroh.dart';
import 'Screens/tata_cara_haji.dart';
import 'Screens/peta_jarak.dart';
import 'Screens/lokasi_ziarah.dart';
import 'Screens/fiqih_haji.dart';
import 'Screens/waktu-sholat.dart';
import 'Screens/travel_screen.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Entry Point ─────────────────────────────────────────────────────────────
void main() {
  runApp(const RavolaApp());
}

// ─── Theme Notifier ───────────────────────────────────────────────────────────
class ThemeNotifier extends ValueNotifier<bool> {
  ThemeNotifier() : super(false);
}

final themeNotifier = ThemeNotifier();

// ─── Root App ─────────────────────────────────────────────────────────────────
class RavolaApp extends StatelessWidget {
  const RavolaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: themeNotifier,
      builder: (context, isDark, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: isDark ? Brightness.dark : Brightness.light,
          ),
          home: const HomeScreen(),
          routes: {
            '/persiapan-haji': (context) => PersiapanHajiScreen(isDark: isDark),
            '/fiqih-umroh': (context) => FiqihUmrohScreen(isDark: isDark),
            '/dzikir-doa': (context) => DzikirDoaScreen(isDark: isDark),
            '/tata-cara-umroh': (context) =>
                TataCaraUmrohScreen(isDark: isDark),
            '/tata-cara-haji': (context) => TataCaraHajiScreen(isDark: isDark),
            '/peta-jarak': (context) => PetaJarakScreen(isDark: isDark),
            '/lokasi-ziarah': (context) => LokasiZiarahScreen(isDark: isDark),
            '/fiqih-haji': (context) => FiqihHajiScreen(isDark: isDark),
            '/waktu-sholat': (context) => WaktuSholatScreen(isDark: isDark),
            '/search': (context) => const TravelScreen(),
            '/theme-settings': (context) => ThemeSettingsScreen(isDark: isDark),
          },
        );
      },
    );
  }
}

// ─── Menu Items ───────────────────────────────────────────────────────────────
class MenuItem {
  final String title;
  final String imagePath;
  final String route;

  const MenuItem({
    required this.title,
    required this.imagePath,
    required this.route,
  });
}

const List<MenuItem> menuItems = [
  MenuItem(
    title: "Persiapan Haji",
    imagePath: "assets/images/persiapann.jpg",
    route: "/persiapan-haji",
  ),
  MenuItem(
    title: "Fiqih Umroh",
    imagePath: "assets/images/fiqih.jpg",
    route: "/fiqih-umroh",
  ),
  MenuItem(
    title: "Dzikir & Doa",
    imagePath: "assets/images/dzikir.jpg",
    route: "/dzikir-doa",
  ),
  MenuItem(
    title: "Tata Cara Umroh",
    imagePath: "assets/images/tatacara1.jpg",
    route: "/tata-cara-umroh",
  ),
  MenuItem(
    title: "Tata Cara Haji",
    imagePath: "assets/images/tata.jpg",
    route: "/tata-cara-haji",
  ),
  MenuItem(
    title: "Peta Jarak",
    imagePath: "assets/images/Peta.jpg",
    route: "/peta-jarak",
  ),
  MenuItem(
    title: "Lokasi Ziarah",
    imagePath: "assets/images/Persiapan.jpg",
    route: "/lokasi-ziarah",
  ),
  MenuItem(
    title: "Fiqih Haji",
    imagePath: "assets/images/FiqihHaji.jpg",
    route: "/fiqih-haji",
  ),
];

// ─── Theme Colors ─────────────────────────────────────────────────────────────
class AppTheme {
  final Color background;
  final Color cardBottom;
  final Color cardTitle;
  final Color dockBg;
  final Color dockIcon;
  final Color activeDot;

  const AppTheme({
    required this.background,
    required this.cardBottom,
    required this.cardTitle,
    required this.dockBg,
    required this.dockIcon,
    required this.activeDot,
  });

  static const light = AppTheme(
    background: Color(0xFFF2F2F2),
    cardBottom: Color(0xBF000000),
    cardTitle: Color(0xFFFFFFFF),
    dockBg: Color(0xFFD3AB3F),
    dockIcon: Colors.white,
    activeDot: Colors.white,
  );

  static const dark = AppTheme(
    background: Color(0xFF121212),
    cardBottom: Color(0xBF000000),
    cardTitle: Color(0xFFC9A84C),
    dockBg: Color(0xFF1A1A1A),
    dockIcon: Color(0xFFC9A84C),
    activeDot: Color(0xFFC9A84C),
  );
}

// ─── Islamic Background ───────────────────────────────────────────────────────
class IslamicBackground extends StatelessWidget {
  final bool isDark;
  const IslamicBackground({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(painter: IslamicBackgroundPainter(isDark: isDark)),
    );
  }
}

class IslamicBackgroundPainter extends CustomPainter {
  final bool isDark;
  IslamicBackgroundPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAF7);
    final gold = const Color(0xFFC9A84C);
    final op = isDark ? 0.42 : 0.45;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = bg,
    );

    final strokePaint = Paint()
      ..color = gold.withOpacity(op + 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final fillPaint = Paint()
      ..color = gold.withOpacity(op)
      ..style = PaintingStyle.fill;

    _drawArc(canvas, strokePaint, Offset(0, 60), Offset(60, 0), Offset(0, 0));
    _drawArc(
      canvas,
      Paint()
        ..color = gold.withOpacity(op + 0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8,
      Offset(0, 40),
      Offset(40, 0),
      Offset(0, 0),
    );
    canvas.drawCircle(const Offset(0, 0), 5, fillPaint);
    canvas.drawCircle(const Offset(28, 6), 3, fillPaint);
    canvas.drawCircle(const Offset(6, 28), 3, fillPaint);

    _drawArc(
      canvas,
      strokePaint,
      Offset(size.width, 60),
      Offset(size.width - 60, 0),
      Offset(size.width, 0),
    );
    _drawArc(
      canvas,
      Paint()
        ..color = gold.withOpacity(op + 0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8,
      Offset(size.width, 40),
      Offset(size.width - 40, 0),
      Offset(size.width, 0),
    );
    canvas.drawCircle(Offset(size.width, 0), 5, fillPaint);
    canvas.drawCircle(Offset(size.width - 28, 6), 3, fillPaint);
    canvas.drawCircle(Offset(size.width - 6, 28), 3, fillPaint);

    _drawArc(
      canvas,
      strokePaint,
      Offset(0, size.height - 60),
      Offset(60, size.height),
      Offset(0, size.height),
    );
    canvas.drawCircle(Offset(0, size.height), 5, fillPaint);
    canvas.drawCircle(Offset(28, size.height - 6), 3, fillPaint);
    canvas.drawCircle(Offset(6, size.height - 28), 3, fillPaint);

    _drawArc(
      canvas,
      strokePaint,
      Offset(size.width, size.height - 60),
      Offset(size.width - 60, size.height),
      Offset(size.width, size.height),
    );
    canvas.drawCircle(Offset(size.width, size.height), 5, fillPaint);
    canvas.drawCircle(Offset(size.width - 28, size.height - 6), 3, fillPaint);
    canvas.drawCircle(Offset(size.width - 6, size.height - 28), 3, fillPaint);

    _drawIslamicStar(
      canvas,
      Offset(size.width / 2, 160),
      35,
      gold.withOpacity(op),
    );
    _drawIslamicStar(
      canvas,
      Offset(size.width / 2, 700),
      35,
      gold.withOpacity(op),
    );
    _drawIslamicStar(
      canvas,
      Offset(60, size.height / 2),
      20,
      gold.withOpacity(op * 0.8),
    );
    _drawIslamicStar(
      canvas,
      Offset(size.width - 60, size.height / 2),
      20,
      gold.withOpacity(op * 0.8),
    );

    _drawVine(canvas, gold.withOpacity(op + 0.05), size.width, 100, 0.8);
    _drawVine(canvas, gold.withOpacity(op), size.width, 110, 0.5);
    _drawVine(
      canvas,
      gold.withOpacity(op + 0.05),
      size.width,
      size.height - 100,
      0.8,
    );
    _drawVine(canvas, gold.withOpacity(op), size.width, size.height - 90, 0.5);
    _drawVine(
      canvas,
      gold.withOpacity(op * 0.7),
      size.width,
      size.height / 2,
      0.6,
    );

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      3,
      Paint()..color = gold.withOpacity(op),
    );

    final diamondPaint = Paint()
      ..color = gold.withOpacity(op)
      ..style = PaintingStyle.fill;
    for (final pt in [
      const Offset(50, 250),
      const Offset(350, 250),
      const Offset(50, 600),
      const Offset(350, 600),
      const Offset(130, 350),
      const Offset(270, 350),
      const Offset(130, 550),
      const Offset(270, 550),
    ]) {
      _drawDiamond(canvas, pt, 8, diamondPaint);
    }
  }

  void _drawArc(
    Canvas canvas,
    Paint paint,
    Offset start,
    Offset end,
    Offset ctrl,
  ) {
    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..quadraticBezierTo(ctrl.dx, ctrl.dy, end.dx, end.dy);
    canvas.drawPath(path, paint);
  }

  void _drawIslamicStar(Canvas canvas, Offset center, double r, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    _drawStarPolygon(canvas, center, r, 0, paint);
    _drawStarPolygon(canvas, center, r, math.pi / 4, paint);
  }

  void _drawStarPolygon(
    Canvas canvas,
    Offset center,
    double r,
    double rotation,
    Paint paint,
  ) {
    final points = <Offset>[];
    final angles = [0, 45, 90, 135, 180, 225, 270, 315];
    final radii = [r, r / 4.0, r, r / 4.0, r, r / 4.0, r, r / 4.0];
    for (int i = 0; i < 8; i++) {
      final a = (angles[i] * math.pi / 180) + rotation - math.pi / 2;
      points.add(
        Offset(
          center.dx + radii[i] * math.cos(a),
          center.dy + radii[i] * math.sin(a),
        ),
      );
    }
    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (final p in points.skip(1)) path.lineTo(p.dx, p.dy);
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawVine(
    Canvas canvas,
    Color color,
    double w,
    double y,
    double strokeW,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW;
    final path = Path()
      ..moveTo(20, y)
      ..quadraticBezierTo(70, y - 20, 120, y)
      ..quadraticBezierTo(170, y + 20, 220, y)
      ..quadraticBezierTo(270, y - 20, 320, y)
      ..quadraticBezierTo(370, y + 20, w, y);
    canvas.drawPath(path, paint);
  }

  void _drawDiamond(Canvas canvas, Offset center, double half, Paint paint) {
    final path = Path()
      ..moveTo(center.dx, center.dy - half)
      ..lineTo(center.dx + half / 2, center.dy)
      ..lineTo(center.dx, center.dy + half)
      ..lineTo(center.dx - half / 2, center.dy)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(IslamicBackgroundPainter old) => old.isDark != isDark;
}

// ─── Dock Navbar ──────────────────────────────────────────────────────────────
class Dock extends StatelessWidget {
  final bool isDark;
  final String activeLabel;
  final ValueChanged<String>? onTap;

  const Dock({
    super.key,
    required this.isDark,
    required this.activeLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = isDark ? AppTheme.dark : AppTheme.light;
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.search, 'label': 'Search'},
      {'icon': Icons.access_time, 'label': 'Time'},
      {'icon': Icons.favorite, 'label': 'Health'},
    ];

    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      decoration: BoxDecoration(
        color: t.dockBg,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.white : Colors.black).withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          final isActive = item['label'] == activeLabel;
          return GestureDetector(
            onTap: () {
              final label = item['label'] as String;
              if (label == 'Time') {
                Navigator.pushNamed(context, '/waktu-sholat');
              } else if (label == 'Search') {
                Navigator.pushNamed(context, '/search');
              } else {
                onTap?.call(label);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'] as IconData,
                  color: isActive ? t.activeDot : t.dockIcon.withOpacity(0.6),
                  size: 24,
                ),
                if (isActive)
                  Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: t.activeDot,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─── Sidebar Menu ─────────────────────────────────────────────────────────────
class AppSidebar extends StatelessWidget {
  final bool isDark;
  final VoidCallback onClose;
  final String? loggedInUser = null;

  const AppSidebar({super.key, required this.isDark, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final headerBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFEAB21B);
    final sidebarBg = isDark
        ? const Color(0xFF1C1C1C)
        : const Color(0xFFFFFBF0);
    final gold = const Color(0xFFC9A84C);
    final textDark = isDark ? const Color(0xFFF0E6C8) : const Color(0xFF1A1200);
    final dividerColor = isDark
        ? const Color(0xFF2E2E2E)
        : const Color(0xFFE5D9B6);

    return GestureDetector(
      onTap: onClose,
      child: Stack(
        children: [
          // Overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.45)),
          ),

          // Sidebar panel
          GestureDetector(
            onTap: () {},
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.55,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: sidebarBg,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(4, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
                      decoration: BoxDecoration(color: headerBg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 100,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF2A2A2A)
                                  : Colors.white.withOpacity(0.3),
                            ),
                            child: Center(
                              child: Text(
                                'R',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? gold : Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'RAVOLA',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 3,
                              color: isDark ? gold : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Panduan Haji & Umroh',
                            style: TextStyle(
                              fontSize: 10,
                              color: isDark
                                  ? Colors.white54
                                  : Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    _SidebarItem(
                      icon: Icons.palette_outlined,
                      label: 'Theme Settings',
                      isDark: isDark,
                      gold: gold,
                      textColor: textDark,
                      onTap: () {
                        onClose();
                        Navigator.pushNamed(context, '/theme-settings');
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Divider(color: dividerColor, height: 1),
                    ),

                    _SidebarItem(
                      icon: Icons.login_rounded,
                      label: 'Login',
                      isDark: isDark,
                      gold: gold,
                      textColor: textDark,
                      onTap: () {
                        onClose();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Fitur login akan segera hadir',
                            ),
                            backgroundColor: gold,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),

                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'v1.0.0',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.white24 : Colors.black26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ], // ← tutup children Stack AppSidebar
      ), // ← tutup Stack
    ); // ← tutup GestureDetector
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final Color gold;
  final Color textColor;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.gold,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: gold.withOpacity(0.15),
      highlightColor: gold.withOpacity(0.08),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: gold, size: 22),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: gold.withOpacity(0.5), size: 18),
          ],
        ),
      ),
    );
  }
}

// ─── Theme Settings Screen ────────────────────────────────────────────────────
class ThemeSettingsScreen extends StatelessWidget {
  final bool isDark;
  const ThemeSettingsScreen({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: themeNotifier,
      builder: (context, currentDark, _) {
        final gold = const Color(0xFFC9A84C);
        final headerBg = currentDark
            ? const Color(0xFF1A1A1A)
            : const Color(0xFFEAB21B);
        final bgColor = currentDark
            ? const Color(0xFF121212)
            : const Color(0xFFFAFAF7);
        final textPrimary = currentDark
            ? const Color(0xFFF0E6C8)
            : const Color(0xFF1A1200);
        final textSecondary = currentDark
            ? const Color(0xFF9E8A5A)
            : const Color(0xFF8B7332);
        final cardBg = currentDark ? const Color(0xFF1E1E1E) : Colors.white;
        final cardBorder = currentDark
            ? const Color(0xFF2E2E2E)
            : const Color(0xFFE8D9A0);

        return Scaffold(
          backgroundColor: bgColor,
          body: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: headerBg,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          (currentDark ? const Color(0xFFF4B400) : Colors.black)
                              .withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 16, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: currentDark ? gold : Colors.black,
                            size: 20,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Transform.translate(
                          offset: const Offset(-2, -8),
                          child: Text(
                            'Theme Settings',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: currentDark ? gold : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Pilih Tampilan',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: textSecondary,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _ThemeOptionCard(
                        label: 'Light Mode',
                        description: 'Tampilan terang dengan aksen emas',
                        icon: Icons.wb_sunny_rounded,
                        isSelected: !currentDark,
                        gold: gold,
                        cardBg: cardBg,
                        cardBorder: cardBorder,
                        textPrimary: textPrimary,
                        textSecondary: textSecondary,
                        onTap: () => themeNotifier.value = false,
                        previewColors: const [
                          Color(0xFFEAB21B),
                          Color(0xFFFAFAF7),
                          Color(0xFFC9A84C),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _ThemeOptionCard(
                        label: 'Dark Mode',
                        description: 'Tampilan gelap elegan dengan emas',
                        icon: Icons.nightlight_round,
                        isSelected: currentDark,
                        gold: gold,
                        cardBg: cardBg,
                        cardBorder: cardBorder,
                        textPrimary: textPrimary,
                        textSecondary: textSecondary,
                        onTap: () => themeNotifier.value = true,
                        previewColors: const [
                          Color(0xFF121212),
                          Color(0xFF1A1A1A),
                          Color(0xFFC9A84C),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ThemeOptionCard extends StatelessWidget {
  final String label;
  final String description;
  final IconData icon;
  final bool isSelected;
  final Color gold;
  final Color cardBg;
  final Color cardBorder;
  final Color textPrimary;
  final Color textSecondary;
  final VoidCallback onTap;
  final List<Color> previewColors;

  const _ThemeOptionCard({
    required this.label,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.gold,
    required this.cardBg,
    required this.cardBorder,
    required this.textPrimary,
    required this.textSecondary,
    required this.onTap,
    required this.previewColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? gold : cardBorder,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: gold.withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Row(
              children: previewColors
                  .map(
                    (c) => Container(
                      width: 18,
                      height: 18,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(fontSize: 11, color: textSecondary),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? gold : Colors.transparent,
                border: Border.all(
                  color: isSelected ? gold : textSecondary.withOpacity(0.4),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Home Screen ──────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _sidebarOpen = false;
  late AnimationController _sidebarCtrl;
  late Animation<Offset> _slideAnim;
  final String? _loggedInName = null;

  @override
  void initState() {
    super.initState();
    _sidebarCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _slideAnim = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _sidebarCtrl, curve: Curves.easeOutCubic),
        );
  }

  void _openSidebar() {
    setState(() => _sidebarOpen = true);
    _sidebarCtrl.forward();
  }

  void _closeSidebar() {
    _sidebarCtrl.reverse().then((_) {
      if (mounted) setState(() => _sidebarOpen = false);
    });
  }

  @override
  void dispose() {
    _sidebarCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: themeNotifier,
      builder: (context, isDark, _) {
        final t = isDark ? AppTheme.dark : AppTheme.light;

        final greeting = _loggedInName != null
            ? "Assalamu'alaikum, $_loggedInName"
            : "Assalamu'alaikum, Calon Jama'ah";
        final subtitle = _loggedInName != null
            ? "Selamat datang kembali"
            : "Selamat datang di Ravola";

        return Scaffold(
          extendBody: true,
          backgroundColor: t.background,
          body: Stack(
            children: [
              // ── Main Column ──
              Column(
                children: [
                  // ── HEADER ──
                  SizedBox(
                    height: 240,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/bg-home.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.2),
                                  Colors.black.withOpacity(0.4),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(26, 8, 16, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Transform.translate(
                                      offset: const Offset(-12, 0),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.menu_rounded,
                                          color: Colors.white,
                                        ),
                                        onPressed: _openSidebar,
                                      ),
                                    ),
                                    Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? const Color(0xFF2A2A2A)
                                            : Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.person, size: 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  greeting,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.3,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  subtitle,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.2,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), // ← tutup SizedBox header
                  // ── CONTENT PUTIH ──
                  Expanded(
                    child: Transform.translate(
                      offset: const Offset(0, -30),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF121212)
                                : Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, -2),
                              ),
                            ],
                          ),
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 30, 16, 110),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 18,
                                  mainAxisSpacing: 18,
                                  childAspectRatio: 1.0,
                                ),
                            itemCount: menuItems.length,
                            itemBuilder: (context, index) {
                              final item = menuItems[index];
                              return GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, item.route),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Image.asset(
                                          item.imagePath,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                                color: const Color(0xFFCCBB88),
                                                child: const Icon(
                                                  Icons.image,
                                                  size: 40,
                                                  color: Colors.white54,
                                                ),
                                              ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          color: t.cardBottom,
                                          child: Text(
                                            item.title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: t.cardTitle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ), // ← tutup Expanded content putih
                ],
              ), // ← tutup Column
              // ── Dock Navbar ──
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Dock(isDark: isDark, activeLabel: 'Home'),
              ),

              // ── Sidebar Overlay ──
              if (_sidebarOpen)
                SlideTransition(
                  position: _slideAnim,
                  child: AppSidebar(isDark: isDark, onClose: _closeSidebar),
                ),
            ], // ← tutup children Stack
          ), // ← tutup Stack
        ); // ← tutup Scaffold
      },
    );
  }
}
