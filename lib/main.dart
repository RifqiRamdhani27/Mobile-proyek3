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

// ─── Entry Point ─────────────────────────────────────────────────────────────
void main() {
  runApp(const RavolaApp());
}

// ─── Theme Notifier (pengganti useTheme / ThemeContext) ──────────────────────
class ThemeNotifier extends ValueNotifier<bool> {
  ThemeNotifier() : super(false); // false = light, true = dark
}

final themeNotifier = ThemeNotifier();

// ─── Root App ────────────────────────────────────────────────────────────────
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
          },
        );
      },
    );
  }
}

// ─── Menu Items ──────────────────────────────────────────────────────────────
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

// ─── Islamic SVG Background ──────────────────────────────────────────────────
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

    // Background
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

    // ── Corner TL ────────────────────────────────────────────────────────────
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
    canvas.drawCircle(Offset(0, 0), 5, fillPaint);
    canvas.drawCircle(Offset(28, 6), 3, fillPaint);
    canvas.drawCircle(Offset(6, 28), 3, fillPaint);

    // ── Corner TR ────────────────────────────────────────────────────────────
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

    // ── Corner BL ────────────────────────────────────────────────────────────
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

    // ── Corner BR ────────────────────────────────────────────────────────────
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

    // ── Islamic Stars ─────────────────────────────────────────────────────────
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

    // ── Vine Arabesque ────────────────────────────────────────────────────────
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

    // ── Center Vine Dots ──────────────────────────────────────────────────────
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      3,
      Paint()..color = gold.withOpacity(op),
    );
    canvas.drawCircle(
      Offset(120, size.height / 2),
      2,
      Paint()..color = gold.withOpacity(op),
    );
    canvas.drawCircle(
      Offset(280, size.height / 2),
      2,
      Paint()..color = gold.withOpacity(op),
    );

    // ── Diamonds ─────────────────────────────────────────────────────────────
    final diamondPaint = Paint()
      ..color = gold.withOpacity(op)
      ..style = PaintingStyle.fill;
    for (final pt in [
      Offset(50, 250),
      Offset(350, 250),
      Offset(50, 600),
      Offset(350, 600),
      Offset(130, 350),
      Offset(270, 350),
      Offset(130, 550),
      Offset(270, 550),
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

// ─── Moon Switch ─────────────────────────────────────────────────────────────
class MoonSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onValueChange;

  const MoonSwitch({
    super.key,
    required this.value,
    required this.onValueChange,
  });

  @override
  State<MoonSwitch> createState() => _MoonSwitchState();
}

class _MoonSwitchState extends State<MoonSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _anim = Tween<double>(
      begin: 0,
      end: 26,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    if (widget.value) _ctrl.value = 1.0;
  }

  @override
  void didUpdateWidget(MoonSwitch old) {
    super.didUpdateWidget(old);
    widget.value ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onValueChange(!widget.value),
      child: AnimatedBuilder(
        animation: _anim,
        builder: (context, _) {
          return Container(
            width: 60,
            height: 28,
            decoration: BoxDecoration(
              color: widget.value ? const Color(0x33FFB700) : Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.all(4),
            child: Stack(
              children: [
                Positioned(
                  left: _anim.value,
                  child: Container(
                    width: 23,
                    height: 23,
                    decoration: BoxDecoration(
                      color: widget.value
                          ? const Color(0xFF13082D)
                          : const Color(0xFFFFF3B0),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Center(
                      child: widget.value
                          ? const Icon(
                              Icons.nightlight_round,
                              size: 14,
                              color: Color(0xFFDCDCDC),
                            )
                          : const Icon(
                              Icons.wb_sunny,
                              size: 14,
                              color: Color(0xFFFF8C00),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─── Dock Navbar ─────────────────────────────────────────────────────────────
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

// ─── Home Screen ─────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: themeNotifier,
      builder: (context, isDark, _) {
        final t = isDark ? AppTheme.dark : AppTheme.light;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // ── Islamic Background ─────────────────────────────────────────
              IslamicBackground(isDark: isDark),

              Column(
                children: [
                  // ── AppBar ─────────────────────────────────────────────────
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xEE1A1A1A)
                          : const Color(0xFFEAB21B),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              (isDark ? const Color(0xFFF4B400) : Colors.black)
                                  .withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 0, 16, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'RAVOLA',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 3,
                                color: isDark
                                    ? const Color(0xFFC9A84C)
                                    : Colors.black,
                                // Ganti dengan font Cinzel jika sudah di-add di pubspec
                                // fontFamily: 'CinzelDecorative',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 18,
                                right: 5,
                              ),
                              child: MoonSwitch(
                                value: isDark,
                                onValueChange: (v) => themeNotifier.value = v,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // ── Grid Menu ──────────────────────────────────────────────
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 26, 16, 110),
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
                          onTap: () {
                            Navigator.pushNamed(context, item.route);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                // Card Image
                                Positioned.fill(
                                  child: Image.asset(
                                    item.imagePath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: const Color(0xFFCCBB88),
                                      child: const Icon(
                                        Icons.image,
                                        size: 40,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ),
                                ),
                                // Card Bottom Label
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
                ],
              ),

              // ── Dock Navbar ────────────────────────────────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Dock(isDark: isDark, activeLabel: 'Home'),
              ),
            ],
          ),
        );
      },
    );
  }
}
