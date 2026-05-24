import 'package:flutter/material.dart';

// Biar intro tidak mengulang saat hot reload
bool _splashShown = false;

class SplashScreen extends StatefulWidget {
  final Widget home;

  const SplashScreen({super.key, required this.home});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _reveal;
  late Animation<double> _fade;

  bool _done = false;

  @override
  void initState() {
    super.initState();

    if (_splashShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _goHome());
      return;
    }

    // Durasi total
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8000),
    );

    // 1. Proses memunculkan logo dibuat lambat (3 detik pertama dari total 6 detik)
    _reveal = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.70, curve: Curves.easeOutQuad),
    );

    // 2. Proses memudarkan logo dibuat agak cepat di akhir (0.8 detik terakhir)
    // Jeda dari 0.50 ke 0.86 (sekitar 2.2 detik) adalah waktu logo DIAM UTUH 100%
    _fade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.86, 1.0, curve: Curves.easeInOut),
    );

    _start();
  }

  Future<void> _start() async {
    await _ctrl.forward();
    _splashShown = true;
    _goHome();
  }

  void _goHome() {
    if (!_done && mounted) {
      _done = true;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget.home,
          transitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _logoReveal() {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return Opacity(
          opacity: 1.0 - _fade.value, // Efek seettt pudar cepat di akhir
          child: ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: const [
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                  Colors.transparent,
                ],
                stops: [
                  0.0,
                  (_reveal.value * 1.2) -
                      0.1, // Tepian pudar halus saat menyapu
                  (_reveal.value * 1.2),
                  1.0,
                ],
              ).createShader(bounds);
            },
            child: SizedBox(
              width: 280, // Sesuaikan dengan ukuran aset PNG Ravola kamu
              child: Image.asset(
                'assets/images/ravola_logo.png', //
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_splashShown) return widget.home;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background utama
          Image.asset('assets/images/ravola_bg.jpg', fit: BoxFit.cover), //
          // 2. Logo Tengah dengan animasi sapuan lambat & premium
          Center(child: _logoReveal()),
        ],
      ),
    );
  }
}
