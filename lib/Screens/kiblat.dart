import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class QiblaPage extends StatefulWidget {
  final bool isDark;
  const QiblaPage({super.key, this.isDark = false});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  bool _loading = true;
  String _errorMsg = '';
  Position? _position;
  String _currentAddress = 'Mencari lokasi...';

  // Koordinat Ka'bah
  static const double _kaabaLat = 21.4225;
  static const double _kaabaLng = 39.8262;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    setState(() {
      _loading = true;
      _errorMsg = '';
    });

    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      setState(() {
        _loading = false;
        _errorMsg = 'Izin lokasi ditolak. Aktifkan di pengaturan.';
      });
      return;
    }

    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Ambil nama kota/kabupaten
      List<Placemark> placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      String city = 'Lokasi tidak dikenal';
      if (placemarks.isNotEmpty) {
        // Mengambil subAdministrativeArea biasanya berisi Kabupaten/Kota
        city =
            placemarks[0].subAdministrativeArea ??
            placemarks[0].locality ??
            placemarks[0].administrativeArea ??
            'Lokasi tidak dikenal';
      }

      setState(() {
        _position = pos;
        _currentAddress = city;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMsg = 'Gagal mendapatkan lokasi.';
      });
    }
  }

  double _calcQiblaAngle(double userLat, double userLng) {
    final lat1 = userLat * pi / 180;
    final lat2 = _kaabaLat * pi / 180;
    final dLng = (_kaabaLng - userLng) * pi / 180;

    final y = sin(dLng) * cos(lat2);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLng);
    final bearing = atan2(y, x) * 180 / pi;
    return (bearing + 360) % 360;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFF7F7F7);
    final textPrimary = isDark
        ? const Color(0xFFC9A84C)
        : const Color(0xFFB8860B);
    final textSecondary = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bg,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/kompas.png',
              fit: BoxFit.cover,
              gaplessPlayback: true,
              color: isDark ? Colors.black.withOpacity(0.4) : null,
              colorBlendMode: isDark ? BlendMode.darken : null,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: bg),
            ),
          ),

          // KONTEN UI
          _loading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.orange),
                )
              : _errorMsg.isNotEmpty
              ? SafeArea(child: _buildError())
              : StreamBuilder<CompassEvent>(
                  stream: FlutterCompass.events,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.orange),
                      );
                    }
                    if (snapshot.data!.heading == null) {
                      return const Center(
                        child: Text('Sensor kompas tidak tersedia.'),
                      );
                    }

                    final heading = snapshot.data!.heading!;
                    final qiblaAngleDeg = _calcQiblaAngle(
                      _position!.latitude,
                      _position!.longitude,
                    );

                    // rotateRad adalah sudut rotasi jarum relatif terhadap heading HP
                    final rotateRad = (qiblaAngleDeg - heading) * pi / 180;

                    return SafeArea(
                      child: _buildUI(
                        rotateRad,
                        qiblaAngleDeg,
                        heading,
                        isDark,
                        textPrimary,
                        textSecondary,
                        snapshot.data!.accuracy,
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_off, size: 60, color: Colors.orange),
            const SizedBox(height: 12),
            Text(
              _errorMsg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _init,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text(
                'Coba Lagi',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUI(
    double rotateRad,
    double qiblaAngleDeg,
    double heading,
    bool isDark,
    Color textPrimary,
    Color textSecondary,
    double? compassAccuracy,
  ) {
    // Menghitung label arah kardinal (N, E, S, W) berdasarkan heading
    String getDirection(double h) {
      if (h >= 337.5 || h < 22.5) return 'Utara';
      if (h >= 22.5 && h < 67.5) return 'Timur Laut';
      if (h >= 67.5 && h < 112.5) return 'Timur';
      if (h >= 112.5 && h < 157.5) return 'Tenggara';
      if (h >= 157.5 && h < 202.5) return 'Selatan';
      if (h >= 202.5 && h < 247.5) return 'Barat Daya';
      if (h >= 247.5 && h < 292.5) return 'Barat';
      if (h >= 292.5 && h < 337.5) return 'Barat Laut';
      return '';
    }

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // HEADER - Hanya Tombol Back
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: _circleIcon(Icons.arrow_back, isDark),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TITLE
            Column(
              children: [
                Text(
                  "Arah",
                  style: TextStyle(fontSize: 18, color: textSecondary),
                ),
                Text(
                  "KIBLAT",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  "untuk Sholat",
                  style: TextStyle(fontSize: 16, color: textSecondary),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // LOCATION - Dinamis
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.white.withOpacity(0.3),
                border: Border.all(color: Colors.orange.withOpacity(0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    _currentAddress,
                    style: TextStyle(color: textSecondary, fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // COMPASS
            Stack(
              alignment: Alignment.center,
              children: [
                // Ring luar tebal (hitam→emas untuk light, tetap sweep orange untuk dark)
                Container(
                  width: 290,
                  height: 290,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isDark
                        ? SweepGradient(
                            colors: [
                              const Color(0xFFFFB300),
                              const Color(0xFFFF5500),
                              const Color(0xFFFFB300),
                            ],
                          )
                        : SweepGradient(
                            center: Alignment.center,
                            colors: [
                              const Color(0xFF4A0404),
                              const Color(0xFFB8860B),
                              const Color(0xFFD4AF37),
                              const Color(0xFFB8860B),
                              const Color(0xFF4A0404),
                            ],
                            stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                          ),
                  ),
                ),
                // Ring dalam tipis (gap putih/gelap)
                Container(
                  width: 268,
                  height: 268,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark
                        ? const Color(0xFF1A1A1A)
                        : const Color(0xFFFFF8F0),
                  ),
                ),
                // Ring garis emas tipis
                Container(
                  width: 258,
                  height: 258,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFCFA84C).withOpacity(0.6),
                      width: 1.2,
                    ),
                    color: Colors.transparent,
                  ),
                ),
                // Lingkaran dalam utama
                Container(
                  width: 248,
                  height: 248,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark
                        ? const Color(0xFF1E1E1E).withOpacity(0.95)
                        : const Color(0xFFFFFAF0).withOpacity(0.95),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.15),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                // 4 diamond tick mark (N/S/E/W)
                ...List.generate(4, (i) {
                  final angle = i * pi / 2;
                  const r = 118.0;
                  return Transform.translate(
                    offset: Offset(r * sin(angle), -r * cos(angle)),
                    child: Transform.rotate(
                      angle: angle,
                      child: Icon(
                        Icons.diamond,
                        size: 10,
                        color: const Color(
                          0xFFCFA84C,
                        ).withOpacity(isDark ? 0.8 : 0.7),
                      ),
                    ),
                  );
                }),
                // Jarum kiblat rotate
                AnimatedRotation(
                  turns: rotateRad / (2 * pi),
                  duration: const Duration(milliseconds: 200),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Jarum custom mirip gambar (panah lancip atas + ekor V)
                      CustomPaint(
                        size: const Size(60, 90),
                        painter: _QiblatNeedlePainter(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "• KIBLAT •",
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xFFCFA84C),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF2A2A2A), const Color(0xFF1A1A1A)]
                      : [Colors.orange.shade300, Colors.orange.shade500],
                ),
                border: isDark
                    ? Border.all(color: textPrimary.withOpacity(0.3))
                    : null,
              ),
              child: Column(
                children: [
                  Text(
                    "Posisi HP Saat Ini",
                    style: TextStyle(
                      color: isDark ? textPrimary : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${heading.toStringAsFixed(0)}° ${getDirection(heading)}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark ? textPrimary : Colors.white,
                    ),
                  ),
                  Text(
                    "Kiblat: ${qiblaAngleDeg.toStringAsFixed(1)}° dari Utara",
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white38 : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // INFO CARD - Data Asli
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E1E1E).withOpacity(0.9)
                      : Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black26 : Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _InfoItem(
                      Icons.place,
                      "Kota",
                      _currentAddress.split(' ').last,
                      isDark,
                    ),
                    _InfoItem(
                      Icons.gps_fixed,
                      "Akurasi",
                      compassAccuracy != null
                          ? "±${compassAccuracy.toStringAsFixed(0)}°"
                          : "-",
                      isDark,
                    ),
                    _InfoItem(
                      Icons.map,
                      "Lat",
                      "${_position?.latitude.toStringAsFixed(2)}°",
                      isDark,
                    ),
                    _InfoItem(
                      Icons.explore,
                      "Kiblat",
                      "${qiblaAngleDeg.toStringAsFixed(0)}°",
                      isDark,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark
            ? const Color(0xFF1E1E1E).withOpacity(0.8)
            : Colors.white.withOpacity(0.8),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
        border: isDark ? Border.all(color: Colors.white10) : null,
      ),
      child: Icon(icon, color: Colors.orange, size: 20),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isDark;
  const _InfoItem(this.icon, this.title, this.value, this.isDark);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.orange, size: 20),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _QiblatNeedlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Bagian atas jarum (kuning-oranye, lancip ke atas)
    final topPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [const Color(0xFFFFD700), const Color(0xFFFF6600)],
      ).createShader(Rect.fromLTWH(0, 0, w, h * 0.65));

    final topPath = Path()
      ..moveTo(w / 2, 0) // ujung lancip atas
      ..lineTo(w * 0.85, h * 0.65) // kanan bawah
      ..lineTo(w / 2, h * 0.52) // lekukan tengah
      ..lineTo(w * 0.15, h * 0.65) // kiri bawah
      ..close();
    canvas.drawPath(topPath, topPaint);

    // Bagian bawah jarum (ekor V merah terbalik)
    final botPaint = Paint()..color = const Color(0xFFCC2200);

    final botPath = Path()
      ..moveTo(w * 0.15, h * 0.65) // kiri atas ekor
      ..lineTo(w / 2, h * 0.52) // lekukan tengah
      ..lineTo(w * 0.85, h * 0.65) // kanan atas ekor
      ..lineTo(w * 0.72, h) // kanan bawah
      ..lineTo(w / 2, h * 0.82) // tengah bawah
      ..lineTo(w * 0.28, h) // kiri bawah
      ..close();
    canvas.drawPath(botPath, botPaint);
  }

  @override
  bool shouldRepaint(_QiblatNeedlePainter old) => false;
}
