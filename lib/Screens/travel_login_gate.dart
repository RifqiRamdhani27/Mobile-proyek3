import 'package:flutter/material.dart';

const Color kGold = Color(0xFFF5B400);
const Color kGoldLight = Color(0xFFFFF8E1);

// ─── LOGIN GATE WIDGET (mirip tampilan web) ───────────────────────────────────
class TravelLoginGate extends StatefulWidget {
  final VoidCallback onLoginTap;
  const TravelLoginGate({super.key, required this.onLoginTap});

  @override
  State<TravelLoginGate> createState() => _TravelLoginGateState();
}

class _TravelLoginGateState extends State<TravelLoginGate>
    with TickerProviderStateMixin {
  late AnimationController _textCtrl;
  late AnimationController _btnCtrl;
  late AnimationController _imgCtrl;

  late Animation<Offset> _textSlide;
  late Animation<double> _textFade;
  late Animation<Offset> _btnSlide;
  late Animation<double> _btnFade;
  late Animation<double> _imgFade;
  late Animation<Offset> _imgSlide;

  bool _btnPressed = false;

  @override
  void initState() {
    super.initState();

    // Text animation (slide from left)
    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(-1.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOutCubic));
    _textFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut),
    );

    // Button animation (elliptic slide from left)
    _btnCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _btnSlide = Tween<Offset>(
      begin: const Offset(-2.0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _btnCtrl, curve: Curves.easeOutBack));
    _btnFade = Tween<double>(begin: 0, end: 1).animate(_btnCtrl);

    // Image animation (fade + slide from right)
    _imgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _imgFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _imgCtrl, curve: Curves.easeOut),
    );
    _imgSlide = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _imgCtrl, curve: Curves.easeOutCubic));

    // Mulai animasi dengan delay bertahap
    _textCtrl.forward();
    Future.delayed(
      const Duration(milliseconds: 300),
          () { if (mounted) _imgCtrl.forward(); },
    );
    Future.delayed(
      const Duration(milliseconds: 500),
          () { if (mounted) _btnCtrl.forward(); },
    );
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _btnCtrl.dispose();
    _imgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF8F2),
      child: Stack(
        children: [
          // Background pattern Islamic geometric (mirip body::before CSS)
          Positioned.fill(child: CustomPaint(painter: _IslamicPatternPainter())),

          // Gradient overlay (mirip body::after CSS)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    Color(0x00FAF8F2),
                    Color(0xD9FAF8F2),
                    Color(0xFFFAF8F2),
                  ],
                  stops: [0.0, 0.65, 1.0],
                ),
              ),
            ),
          ),

          // Konten utama
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Layout 2 kolom kalau lebar (tablet/landscape), 1 kolom kalau portrait
                if (constraints.maxWidth > 600) {
                  return _buildWideLayout();
                }
                return _buildNarrowLayout();
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Layout lebar: teks kiri + gambar kanan (mirip web desktop) ──────────────
  Widget _buildWideLayout() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(48, 40, 24, 40),
            child: _buildTextContent(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _buildMekahImage(),
          ),
        ),
      ],
    );
  }

  // ── Layout sempit: teks + tombol saja (mobile portrait) ────────────────────
  Widget _buildNarrowLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 32, 28, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextContent(),
        ],
      ),
    );
  }

  // ── Konten teks: label + judul + paragraf + tombol ──────────────────────────
  Widget _buildTextContent() {
    return SlideTransition(
      position: _textSlide,
      child: FadeTransition(
        opacity: _textFade,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Label emas (mirip .label di CSS)
            const Text(
              'SELAMAT DATANG DI RAVOLA',
              style: TextStyle(
                color: Color(0xFFD4A017),
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 18),

            // Judul besar (mirip h1)
            const Text(
              'Sahabat Perjalanan\nIbadah Anda',
              style: TextStyle(
                fontSize: 34,
                color: Color(0xFF16384C),
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 16),

            // Paragraf deskripsi
            const Text(
              'Temukan informasi dari berbagai travel terpercaya.\nSiap membantu anda untuk informasi haji dan umrah.',
              style: TextStyle(
                color: Color(0xFF304B57),
                fontSize: 14,
                height: 1.65,
              ),
            ),
            const SizedBox(height: 36),

            // Tombol Google (mirip .btn-login + .btn-google-animate di CSS)
            SlideTransition(
              position: _btnSlide,
              child: FadeTransition(
                opacity: _btnFade,
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _btnPressed = true),
                  onTapUp: (_) {
                    setState(() => _btnPressed = false);
                    widget.onLoginTap();
                  },
                  onTapCancel: () => setState(() => _btnPressed = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    transform: Matrix4.translationValues(
                      0,
                      _btnPressed ? 2 : -2,
                      0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: _btnPressed
                          ? const Color(0xFF082A39)
                          : const Color(0xFF0C3B50),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            _btnPressed ? 0.25 : 0.45,
                          ),
                          blurRadius: _btnPressed ? 6 : 14,
                          offset: Offset(4, _btnPressed ? 2 : 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _GoogleGIcon(size: 20),
                        const SizedBox(width: 12),
                        const Text(
                          'Masuk dengan Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Gambar Mekah (kanan, hanya tampil di layout lebar) ─────────────────────
  Widget _buildMekahImage() {
    return SlideTransition(
      position: _imgSlide,
      child: FadeTransition(
        opacity: _imgFade,
        child: Image.asset(
          'assets/images/mekah.png',
          fit: BoxFit.contain,
          // Fallback kalau gambar belum ada
          errorBuilder: (_, __, ___) => Container(
            height: 260,
            decoration: BoxDecoration(
              color: kGoldLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(Icons.mosque, size: 80, color: kGold),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Google G Logo ────────────────────────────────────────────────────────────
class _GoogleGIcon extends StatelessWidget {
  final double size;
  const _GoogleGIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    void arc(double startDeg, double sweepDeg, Color color) {
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      final path = Path()
        ..moveTo(c.dx, c.dy)
        ..arcTo(
          Rect.fromCircle(center: c, radius: r),
          startDeg * 3.14159 / 180,
          sweepDeg * 3.14159 / 180,
          false,
        )
        ..close();
      canvas.drawPath(path, paint);
    }

    arc(-10, 90, const Color(0xFF4285F4));
    arc(80, 100, const Color(0xFF34A853));
    arc(180, 100, const Color(0xFFFBBC05));
    arc(280, 80, const Color(0xFFEA4335));

    // Lubang tengah
    canvas.drawCircle(c, r * 0.52, Paint()..color = Colors.white);

    // Bar horizontal biru
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          c.dx - r * 0.05,
          c.dy - r * 0.18,
          c.dx + r,
          c.dy + r * 0.18,
        ),
        const Radius.circular(3),
      ),
      Paint()..color = const Color(0xFF4285F4),
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── Islamic Pattern Background ───────────────────────────────────────────────
class _IslamicPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC9970C).withOpacity(0.13)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    const tileSize = 110.0;
    final cols = (size.width / tileSize).ceil() + 1;
    final rows = (size.height / tileSize).ceil() + 1;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final cx = col * tileSize + tileSize / 2;
        final cy = row * tileSize + tileSize / 2;
        final r = tileSize * 0.42;

        _drawOctagon(canvas, Offset(cx, cy), r, paint);
        _drawOctagon(canvas, Offset(cx, cy), r * 0.65, paint);
        _drawDiamond(canvas, Offset(cx, cy), r * 0.3, paint);
        canvas.drawCircle(Offset(cx, cy), r * 0.09, paint);

        // Cross lines (mirip SVG <line> di CSS background)
        canvas.drawLine(
          Offset(cx - r, cy),
          Offset(cx + r, cy),
          paint,
        );
        canvas.drawLine(
          Offset(cx, cy - r),
          Offset(cx, cy + r),
          paint,
        );
      }
    }
  }

  void _drawOctagon(Canvas canvas, Offset center, double r, Paint paint) {
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final deg = i * 45.0 - 22.5;
      final rad = deg * 3.14159265 / 180;
      final pt = Offset(
        center.dx + r * _cos(rad),
        center.dy + r * _sin(rad),
      );
      i == 0 ? path.moveTo(pt.dx, pt.dy) : path.lineTo(pt.dx, pt.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawDiamond(Canvas canvas, Offset center, double r, Paint paint) {
    final path = Path()
      ..moveTo(center.dx, center.dy - r)
      ..lineTo(center.dx + r * 0.6, center.dy)
      ..lineTo(center.dx, center.dy + r)
      ..lineTo(center.dx - r * 0.6, center.dy)
      ..close();
    canvas.drawPath(path, paint);
  }

  // Trig helpers pakai dart:math lebih aman
  double _cos(double rad) {
    // simple approximation for pattern drawing
    double x = rad;
    while (x > 3.14159) x -= 6.28318;
    while (x < -3.14159) x += 6.28318;
    final s = x - (x*x*x)/6 + (x*x*x*x*x)/120;
    final pi2 = 1.5707963;
    final r2 = pi2 - x;
    return r2 - (r2*r2*r2)/6 + (r2*r2*r2*r2*r2)/120;
  }

  double _sin(double rad) {
    double x = rad;
    while (x > 3.14159) x -= 6.28318;
    while (x < -3.14159) x += 6.28318;
    return x - (x*x*x)/6 + (x*x*x*x*x)/120;
  }

  @override
  bool shouldRepaint(_) => false;
}