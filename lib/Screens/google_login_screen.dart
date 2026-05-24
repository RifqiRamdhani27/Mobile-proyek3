import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter_application/main.dart';
import 'package:flutter_application/config.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/services.dart';

class GoogleLoginScreen extends StatefulWidget {
  final bool isDark;
  const GoogleLoginScreen({super.key, required this.isDark});

  @override
  State<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  String? _errorMessage;

  late AnimationController _fadeCtrl;
  late AnimationController _pulseCtrl;
  late AnimationController _rotateCtrl;

  late Animation<double> _fadeAnim;
  late Animation<double> _slideAnim;
  late Animation<double> _pulseAnim;
  late Animation<double> _rotateAnim;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '469697081666-p9juvoqg6b9287oup54fk61omr01ga8b.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  @override
  void initState() {
    super.initState();

    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _rotateCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();

    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<double>(
      begin: 40,
      end: 0,
    ).animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOutCubic));
    _pulseAnim = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
    _rotateAnim = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_rotateCtrl);

    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _pulseCtrl.dispose();
    _rotateCtrl.dispose();
    super.dispose();
  }

  // Google Sign-In Logic
  Future<Map<String, String>> _solveChallenge(String url) async {
    // Kita harus pake User-Agent yang konsisten.
    final headers = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
    };

    // Kita akses URL target,
    // untuk memancing server Hosting mengeluarkan "Soal Ujian" (HTML Challenge)
    final firstResponse = await http.get(Uri.parse(url), headers: headers);
    final html = firstResponse.body;

    // VALIDASI: Cek apakah di dalam HTML ada kata 'slowAES'.
    // Kalau nggak ada, berarti server lagi nggak kasih tantangan
    if (!html.contains('slowAES')) {
      return {};
    }

    // PASANG RADAR (RegExp): Mencari pola teks a=toNumbers("..."),
    // b=toNumbers("..."), dan c=toNumbers("...")
    final regA = RegExp(r'a=toNumbers\("([a-f0-9]+)"\)');
    final regB = RegExp(r'b=toNumbers\("([a-f0-9]+)"\)');
    final regC = RegExp(r'c=toNumbers\("([a-f0-9]+)"\)');

    // EKSTRAKSI: Ambil isi di dalam tanda kurung (angkanya aja) dari hasil radar tadi
    // group(1) artinya mengambil data yang ada di dalam ( ... ) pada RegExp
    final a = regA.firstMatch(html)?.group(1) ?? '';
    final b = regB.firstMatch(html)?.group(1) ?? '';
    final c = regC.firstMatch(html)?.group(1) ?? '';

    final key = enc.Key.fromBase16(a);
    // 1. Kita nyuruh library: "Jadikan angka 'a' tadi sebagai Kunci AES"
    final iv = enc.IV.fromBase16(b);
    // 2. Kita nyuruh library: "Jadikan angka 'b' tadi sebagai IV (Initial Vector)"
    final ciphertext = enc.Encrypted.fromBase16(c);
    final encrypter = enc.Encrypter(
      enc.AES(key, mode: enc.AESMode.cbc, padding: null),
    );
    // 3. Kita nyuruh library: "Nih teka-tekinya (c),
    // tolong pecahin pake mesin AES Mode CBC!"

    final decrypted = encrypter.decryptBytes(ciphertext, iv: iv);
    // 4. DI SINI PROSES HITUNGNYA: Library ngeluarin hasil dekripsi

    // Setelah dihitung sama library, hasilnya masih berupa deretan angka byte.
    // Kita harus ubah jadi teks Hexadecimal lagi biar bisa dikirim balik ke server
    final cookieValue = decrypted
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join('');
    // Mengubah hasil hitungan jadi kode Cookie yang dimengerti server

    return {'__test': cookieValue};
    // Inilah jawaban ujiannya!
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      print(' GOOGLE LOGIN DEBUG ');
      print('idToken: $idToken');
      print('BASE_URL: $BASE_URL');

      if (idToken == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Gagal mendapatkan token.';
        });
        return;
      }

      final targetUrl = '$BASE_URL/api/auth/google/mobile';

      // Kita menyuruh fungsi _solveChallenge buat nyari
      // angka a, b, c di server, ngitung pake AES, dan suruh ngasih hasilnya.
      final cookies = await _solveChallenge(targetUrl);

      // RAPIHIN JAWABAN: Hasil dari _solveChallenge itu kan masih bentuk Map (data mentah).
      // Di sini kita ubah jadi format teks yang dimengerti Server,
      // contohnya: "__test=hasil_itung_tadi"
      final cookieHeader = cookies.entries
          .map((e) => '${e.key}=${e.value}')
          .join('; ');

      // CEK KARTU: Cuma buat mastiin di debug console kalau kodenya beneran dapet.
      print('Bypass Cookie: $cookieHeader');

      // KIRIM DATA ASLI : sekarang kita sudah punya "Kartu Akses" (Cookie) buat nembus satpam InfinityFree.
      final response = await http.post(
        // '?i=1' buat kode tambahan kalau kita udah lolos verifikasi browser
        Uri.parse('$targetUrl?i=1'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',

          // KARTU AKSES: Ini yang paling penting! Tanpa ini, request kita bakal ditolak lagi.
          'Cookie': cookieHeader,

          // Tetap harus pakai User-Agent yang sama biar nggak dicurigai.
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
        },
        // Ini data asli yang mau kita simpan ke database MySQL lewat PHP
        body: jsonEncode({'id_token': idToken}),
      );

      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');

      print('STATUS CODE: ${response.statusCode}');
      print('RESPONSE BODY: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        if (mounted) {
          _showSuccessAndNavigate(
            data['user']['name'] ?? googleUser.displayName ?? 'User',
          );
        }
      } else {
        setState(() {
          _errorMessage = data['message'] ?? 'Login gagal.';
        });
      }
    } catch (e, stackTrace) {
      print('ERROR TYPE: ${e.runtimeType}');
      print('ERROR: $e');
      print('STACKTRACE: $stackTrace');

      if (e is PlatformException) {
        print('CODE: ${e.code}');
        print('MESSAGE: ${e.message}');
        print('DETAILS: ${e.details}');
      }

      setState(() {
        _errorMessage = e is PlatformException
            ? '${e.code} - ${e.message ?? ""}'
            : '$e';
      });
    }
    finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSuccessAndNavigate(String name) {
    final photoUrl = _googleSignIn.currentUser?.photoUrl;
    userNotifier.value = UserSession(name: name, photoUrl: photoUrl);
    Navigator.pop(context, {'name': name, 'loggedIn': true});
  }

  // User Interface
  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final gold = const Color(0xFFC9A84C);
    final bgColor = isDark ? const Color(0xFF0E0E0E) : const Color(0xFFFAF7F0);
    final cardBg = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textPrimary = isDark
        ? const Color(0xFFF0E6C8)
        : const Color(0xFF1A1200);
    final textSecondary = isDark
        ? const Color(0xFF9E8A5A)
        : const Color(0xFF8B7332);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _rotateAnim,
              builder: (_, _) => CustomPaint(
                painter: _IslamicBgPainter(
                  isDark: isDark,
                  rotation: _rotateAnim.value,
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: isDark ? gold : const Color(0xFF5C4000),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: AnimatedBuilder(
                      animation: _slideAnim,
                      builder: (_, child) => Transform.translate(
                        offset: Offset(0, _slideAnim.value),
                        child: child,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),

                            // Logo
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark
                                    ? const Color(0xFF1A1A1A)
                                    : Colors.white,
                                border: Border.all(
                                  color: gold.withOpacity(0.5),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: gold.withOpacity(0.2),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'R',
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w800,
                                    color: gold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            // Title
                            Text(
                              'RAVOLA',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 6,
                                color: gold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Panduan Haji & Umroh',
                              style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 1.5,
                                color: textSecondary,
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Login Card
                            Container(
                              padding: const EdgeInsets.all(28),
                              decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: gold.withOpacity(0.25),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isDark
                                        ? Colors.black.withOpacity(0.4)
                                        : gold.withOpacity(0.12),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Arabic text decoration
                                  Text(
                                    'بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: gold.withOpacity(0.7),
                                      fontFamily: 'serif',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(height: 4),
                                  Container(
                                    height: 1,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          gold.withOpacity(0.4),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),

                                  Text(
                                    'Masuk untuk melanjutkan',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Login dengan akun Google kamu untuk\nmenyimpan progres dan preferensi.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: textSecondary,
                                      height: 1.5,
                                    ),
                                  ),

                                  const SizedBox(height: 28),

                                  // Error Message
                                  if (_errorMessage != null) ...[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(
                                          isDark ? 0.2 : 0.08,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.red.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.error_outline_rounded,
                                            color: Colors.redAccent,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              _errorMessage!,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                  ],

                                  // ── Google Button ──
                                  _isLoading
                                      ? _LoadingIndicator(gold: gold)
                                      : _GoogleSignInButton(
                                          isDark: isDark,
                                          gold: gold,
                                          onTap: _handleGoogleSignIn,
                                        ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 28),

                            // ── Privacy note ──
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                'Dengan masuk, kamu menyetujui Kebijakan Privasi dan Syarat Layanan Ravola.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: textSecondary.withOpacity(0.7),
                                  height: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Google Sign-In Button
class _GoogleSignInButton extends StatefulWidget {
  final bool isDark;
  final Color gold;
  final VoidCallback onTap;

  const _GoogleSignInButton({
    required this.isDark,
    required this.gold,
    required this.onTap,
  });

  @override
  State<_GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<_GoogleSignInButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: widget.isDark
                ? const Color(0xFF242424)
                : const Color(0xFFF8F4E8),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: widget.gold.withOpacity(0.5), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: widget.gold.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google "G" logo
              _GoogleLogo(size: 22),
              const SizedBox(width: 12),
              Text(
                'Masuk dengan Google',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: widget.isDark
                      ? const Color(0xFFF0E6C8)
                      : const Color(0xFF1A1200),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Google Logo SVG-style
class _GoogleLogo extends StatelessWidget {
  final double size;
  const _GoogleLogo({required this.size});

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

    // Blue segment
    _drawArc(canvas, c, r, -10, 90, const Color(0xFF4285F4));
    // Green segment
    _drawArc(canvas, c, r, 80, 100, const Color(0xFF34A853));
    // Yellow segment
    _drawArc(canvas, c, r, 180, 100, const Color(0xFFFBBC05));
    // Red segment
    _drawArc(canvas, c, r, 280, 80, const Color(0xFFEA4335));

    // White center hole
    canvas.drawCircle(c, r * 0.52, Paint()..color = Colors.white);

    // Blue horizontal bar
    final barPaint = Paint()..color = const Color(0xFF4285F4);
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
      barPaint,
    );
  }

  void _drawArc(
    Canvas canvas,
    Offset c,
    double r,
    double startDeg,
    double sweepDeg,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(c.dx, c.dy)
      ..arcTo(
        Rect.fromCircle(center: c, radius: r),
        startDeg * math.pi / 180,
        sweepDeg * math.pi / 180,
        false,
      )
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

// Loading Indicator
class _LoadingIndicator extends StatelessWidget {
  final Color gold;
  const _LoadingIndicator({required this.gold});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: gold.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2.5, color: gold),
          ),
          const SizedBox(width: 12),
          Text(
            'Memverifikasi...',
            style: TextStyle(
              fontSize: 14,
              color: gold,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Islamic Background Painter
class _IslamicBgPainter extends CustomPainter {
  final bool isDark;
  final double rotation;
  _IslamicBgPainter({required this.isDark, required this.rotation});

  @override
  void paint(Canvas canvas, Size size) {
    final gold = const Color(0xFFC9A84C);
    final op = isDark ? 0.06 : 0.08;

    final paint = Paint()
      ..color = gold.withOpacity(op)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // Slowly rotating star in center background
    canvas.save();
    canvas.translate(size.width / 2, size.height * 0.38);
    canvas.rotate(rotation);
    _drawStarOutline(canvas, Offset.zero, 120, paint);
    canvas.restore();

    // Corner ornaments (static)
    _drawCornerArc(canvas, Offset.zero, 80, gold.withOpacity(op + 0.05));
    _drawCornerArc(
      canvas,
      Offset(size.width, 0),
      80,
      gold.withOpacity(op + 0.05),
      flipX: true,
    );

    // Bottom vine
    _drawVine(canvas, size, gold.withOpacity(op + 0.04));
  }

  void _drawStarOutline(Canvas canvas, Offset center, double r, Paint paint) {
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final outerAngle = (i * 45 - 90) * math.pi / 180;
      final innerAngle = outerAngle + (22.5 * math.pi / 180);
      final outer = Offset(
        center.dx + r * math.cos(outerAngle),
        center.dy + r * math.sin(outerAngle),
      );
      final inner = Offset(
        center.dx + (r * 0.4) * math.cos(innerAngle),
        center.dy + (r * 0.4) * math.sin(innerAngle),
      );
      i == 0
          ? path.moveTo(outer.dx, outer.dy)
          : path.lineTo(outer.dx, outer.dy);
      path.lineTo(inner.dx, inner.dy);
    }
    path.close();
    canvas.drawPath(path, paint);

    // Inner circle
    canvas.drawCircle(center, r * 0.25, paint);
    canvas.drawCircle(center, r * 0.5, paint);
  }

  void _drawCornerArc(
    Canvas canvas,
    Offset origin,
    double size,
    Color color, {
    bool flipX = false,
  }) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    for (double s in [size, size * 0.7, size * 0.45]) {
      final path = Path();
      if (!flipX) {
        path.moveTo(origin.dx, origin.dy + s);
        path.quadraticBezierTo(origin.dx, origin.dy, origin.dx + s, origin.dy);
      } else {
        path.moveTo(origin.dx, origin.dy + s);
        path.quadraticBezierTo(origin.dx, origin.dy, origin.dx - s, origin.dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  void _drawVine(Canvas canvas, Size size, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;
    final y = size.height * 0.85;
    final path = Path()
      ..moveTo(20, y)
      ..quadraticBezierTo(80, y - 18, 140, y)
      ..quadraticBezierTo(200, y + 18, 260, y)
      ..quadraticBezierTo(320, y - 18, size.width - 20, y);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_IslamicBgPainter old) =>
      old.rotation != rotation || old.isDark != isDark;
}
