import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ravola/Screens/travel_screen.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// ─── Islamic Background ───────────────────────────────────────────────────────
class IslamicBackgroundTime extends StatelessWidget {
  final bool isDark;
  const IslamicBackgroundTime({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(painter: _IslamicBgPainter(isDark: isDark)),
    );
  }
}

class _IslamicBgPainter extends CustomPainter {
  final bool isDark;
  _IslamicBgPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAF7);
    final gold = const Color(0xFFC9A84C);
    final op = isDark ? 0.42 : 0.45;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = bg,
    );

    final stroke = Paint()
      ..color = gold.withOpacity(op + 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    final fill = Paint()
      ..color = gold.withOpacity(op)
      ..style = PaintingStyle.fill;

    void arc(Offset s, Offset e, Offset c) {
      canvas.drawPath(
        Path()
          ..moveTo(s.dx, s.dy)
          ..quadraticBezierTo(c.dx, c.dy, e.dx, e.dy),
        stroke,
      );
    }

    arc(Offset(0, 60), Offset(60, 0), Offset(0, 0));
    arc(Offset(0, 40), Offset(40, 0), Offset(0, 0));
    canvas.drawCircle(const Offset(0, 0), 5, fill);
    canvas.drawCircle(const Offset(28, 6), 3, fill);
    canvas.drawCircle(const Offset(6, 28), 3, fill);

    arc(
      Offset(size.width, 60),
      Offset(size.width - 60, 0),
      Offset(size.width, 0),
    );
    arc(
      Offset(size.width, 40),
      Offset(size.width - 40, 0),
      Offset(size.width, 0),
    );
    canvas.drawCircle(Offset(size.width, 0), 5, fill);
    canvas.drawCircle(Offset(size.width - 28, 6), 3, fill);
    canvas.drawCircle(Offset(size.width - 6, 28), 3, fill);

    arc(
      Offset(0, size.height - 60),
      Offset(60, size.height),
      Offset(0, size.height),
    );
    canvas.drawCircle(Offset(0, size.height), 5, fill);
    canvas.drawCircle(Offset(28, size.height - 6), 3, fill);
    canvas.drawCircle(Offset(6, size.height - 28), 3, fill);

    arc(
      Offset(size.width, size.height - 60),
      Offset(size.width - 60, size.height),
      Offset(size.width, size.height),
    );
    canvas.drawCircle(Offset(size.width, size.height), 5, fill);
    canvas.drawCircle(Offset(size.width - 28, size.height - 6), 3, fill);
    canvas.drawCircle(Offset(size.width - 6, size.height - 28), 3, fill);

    void star(Offset center, double r, Color color) {
      final p = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      for (final rot in [0.0, math.pi / 4]) {
        final pts = <Offset>[];
        final angles = [0, 45, 90, 135, 180, 225, 270, 315];
        final radii = [r, r / 4, r, r / 4, r, r / 4, r, r / 4];
        for (int i = 0; i < 8; i++) {
          final a = (angles[i] * math.pi / 180) + rot - math.pi / 2;
          pts.add(
            Offset(
              center.dx + radii[i] * math.cos(a),
              center.dy + radii[i] * math.sin(a),
            ),
          );
        }
        final path = Path()..moveTo(pts[0].dx, pts[0].dy);
        for (final pt in pts.skip(1)) {
          path.lineTo(pt.dx, pt.dy);
        }
        path.close();
        canvas.drawPath(path, p);
      }
    }

    star(Offset(size.width / 2, 160), 35, gold.withOpacity(op));
    star(Offset(size.width / 2, 700), 35, gold.withOpacity(op));
    star(Offset(60, size.height / 2), 20, gold.withOpacity(op * 0.8));
    star(
      Offset(size.width - 60, size.height / 2),
      20,
      gold.withOpacity(op * 0.8),
    );

    void vine(Color c, double y, double sw) {
      final p = Paint()
        ..color = c
        ..style = PaintingStyle.stroke
        ..strokeWidth = sw;
      canvas.drawPath(
        Path()
          ..moveTo(20, y)
          ..quadraticBezierTo(70, y - 20, 120, y)
          ..quadraticBezierTo(170, y + 20, 220, y)
          ..quadraticBezierTo(270, y - 20, 320, y)
          ..quadraticBezierTo(370, y + 20, size.width, y),
        p,
      );
    }

    vine(gold.withOpacity(op + 0.05), 100, 0.8);
    vine(gold.withOpacity(op), 110, 0.5);
    vine(gold.withOpacity(op + 0.05), size.height - 100, 0.8);
    vine(gold.withOpacity(op), size.height - 90, 0.5);
    vine(gold.withOpacity(op * 0.7), size.height / 2, 0.6);

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

    void diamond(Offset c, double h) {
      canvas.drawPath(
        Path()
          ..moveTo(c.dx, c.dy - h)
          ..lineTo(c.dx + h / 2, c.dy)
          ..lineTo(c.dx, c.dy + h)
          ..lineTo(c.dx - h / 2, c.dy)
          ..close(),
        Paint()
          ..color = gold.withOpacity(op)
          ..style = PaintingStyle.fill,
      );
    }

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
      diamond(pt, 8);
    }
  }

  @override
  bool shouldRepaint(_IslamicBgPainter old) => old.isDark != isDark;
}

// ─── Waktu Sholat Screen ──────────────────────────────────────────────────────
class WaktuSholatScreen extends StatefulWidget {
  final bool isDark;
  const WaktuSholatScreen({super.key, this.isDark = false});

  @override
  State<WaktuSholatScreen> createState() => _WaktuSholatScreenState();
}

class _WaktuSholatScreenState extends State<WaktuSholatScreen> {
  List<Map<String, String>> sholatTimes = [
    {"name": "Subuh", "time": "04:42"},
    {"name": "Dzuhur", "time": "12:03"},
    {"name": "Ashar", "time": "15:12"},
    {"name": "Maghrib", "time": "18:07"},
    {"name": "Isya", "time": "19:17"},
  ];

  bool loading = true;
  String jamSekarang = "";
  String namaKota = "Mengambil lokasi...";
  String berikutnyaName = "";
  int sisaJam = 0, sisaMenit = 0, sisaDetik = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchJadwal();
    _startClock();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _update());
  }

  void _update() {
    final now = DateTime.now();
    final jam = now.hour.toString().padLeft(2, '0');
    final mnt = now.minute.toString().padLeft(2, '0');

    if (loading) {
      setState(() => jamSekarang = "$jam:$mnt");
      return;
    }

    final totalDetikNow = now.hour * 3600 + now.minute * 60 + now.second;

    final jadwal = sholatTimes.map((s) {
      final parts = s['time']!.split(':');
      final h = int.tryParse(parts[0]) ?? 0;
      final m = int.tryParse(parts[1]) ?? 0;
      return {'name': s['name']!, 'detik': h * 3600 + m * 60};
    }).toList();

    final target = jadwal.firstWhere(
      (s) => (s['detik'] as int) > totalDetikNow,
      orElse: () => jadwal[0],
    );

    int selisih = (target['detik'] as int) - totalDetikNow;
    if (selisih < 0) selisih += 24 * 3600;

    setState(() {
      jamSekarang = "$jam:$mnt";
      berikutnyaName = target['name'] as String;
      sisaJam = selisih ~/ 3600;
      sisaMenit = (selisih % 3600) ~/ 60;
      sisaDetik = selisih % 60;
    });
  }

  Future<void> fetchJadwal() async {
    setState(() {
      loading = true;
      namaKota = "Mengambil lokasi...";
    });
    try {
      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        setState(() {
          namaKota = "Jakarta";
          loading = false;
        });
        return;
      }
      final pos = await Geolocator.getCurrentPosition();
      final lat = pos.latitude;
      final lng = pos.longitude;
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        setState(() {
          namaKota =
              placemarks[0].locality ??
              placemarks[0].subAdministrativeArea ??
              placemarks[0].administrativeArea ??
              "Lokasi";
        });
      }
      final res = await http.get(
        Uri.parse(
          'https://api.aladhan.com/v1/timings?latitude=$lat&longitude=$lng&method=11',
        ),
      );
      final data = jsonDecode(res.body);
      final t = data['data']['timings'];
      setState(() {
        sholatTimes = [
          {"name": "Subuh", "time": (t['Fajr'] as String).substring(0, 5)},
          {"name": "Dzuhur", "time": (t['Dhuhr'] as String).substring(0, 5)},
          {"name": "Ashar", "time": (t['Asr'] as String).substring(0, 5)},
          {"name": "Maghrib", "time": (t['Maghrib'] as String).substring(0, 5)},
          {"name": "Isya", "time": (t['Isha'] as String).substring(0, 5)},
        ];
        loading = false;
      });
    } catch (_) {
      setState(() {
        namaKota = "Jakarta";
        loading = false;
      });
    }
  }

  // formatCountdown — sama persis logika TSX
  String formatCountdown() {
    if (sisaJam >= 1) return "${sisaJam}j ${sisaMenit}m";
    if (sisaMenit >= 1) return "${sisaMenit}m";
    return "${sisaDetik}d";
  }

  String formatLabel() {
    if (sisaJam >= 1) return "lagi";
    if (sisaMenit >= 1) return "menit lagi";
    return "detik lagi";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    // ── Colors 1:1 TSX ────────────────────────────────────────────────────
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFFDF8EE);
    final clockClr = isDark ? const Color(0xFFF4B400) : const Color(0xFF1A1209);
    final brandClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF3A2A00);
    final tagBg = isDark ? const Color(0x18FFFFFF) : const Color(0x25000000);
    final tagClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFFEAEAEA);
    final floatBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final floatBdr = isDark ? const Color(0xFF3A3000) : const Color(0xFFE8C840);
    final labelClr = isDark ? const Color(0xFFB89230) : const Color(0xFF9A8040);
    final valClr = isDark ? const Color(0xFFE0C070) : const Color(0xFF3A2900);
    final cdClr = isDark ? const Color(0xFFF4B400) : const Color(0xFFD4A017);
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final cardBdr = isDark ? const Color(0xFF3A3000) : const Color(0xFF9B8244);
    final curBg = isDark ? const Color(0xFF211904) : const Color(0xFFFFF3CD);
    final curBdr = const Color(0xFFD4A017);
    final nameClr = isDark ? const Color(0xFF9F7B16) : const Color(0xFF2F2F2F);
    final timeClr = isDark ? const Color(0xFFF4B400) : const Color(0xFFB37D00);
    final timeOff = isDark ? const Color(0xFF9F7B16) : const Color(0xFFCDAB57);
    final barBg = isDark ? const Color(0xFF9F7B16) : const Color(0xFFCDAB57);
    final heroGrad = isDark
        ? [const Color(0xFF2E2E2E), const Color(0xFF1B1919)]
        : [const Color(0xFFFFD000), const Color(0xFFD68E00)];

    final activeIndex = sholatTimes.indexWhere(
      (s) => s['name'] == berikutnyaName,
    );

    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          IslamicBackgroundTime(isDark: isDark),

          Column(
            children: [
              // ── hero: height:170 ─────────────────────────────────────────
              SizedBox(
                height: 170,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // goldBlock: absolute top:0 left:0 right:-0.4 height:230 borderBottomRightRadius:70
                    Positioned(
                      top: 0,
                      left: 0,
                      right: -0.4,
                      child: Container(
                        height: 230,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: heroGrad,
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(70),
                          ),
                          border: isDark
                              ? Border(
                                  bottom: BorderSide(
                                    color: const Color(0xFFC9A84C),
                                    width: 0.5,
                                  ),
                                  right: BorderSide(
                                    color: const Color(0xFFC9A84C),
                                    width: 0.5,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),

                    // nav: paddingHorizontal:18 paddingTop:48
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 18,
                            right: 18,
                            top: 38,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // brand: marginLeft:3 marginTop:35
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 3,
                                  top: 85,
                                ),
                                child: Text(
                                  'RAVOLA',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2.5,
                                    color: brandClr,
                                  ),
                                ),
                              ),
                              // right group: row gap:8 right:3.2
                              Transform.translate(
                                offset: const Offset(-3.2, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // locBtn: w:26 h:26 marginTop:28 right:-15
                                    Transform.translate(
                                      offset: const Offset(3, 0),
                                      child: GestureDetector(
                                        onTap: fetchJadwal,
                                        child: Container(
                                          width: 26,
                                          height: 26,
                                          margin: const EdgeInsets.only(
                                            top: 28,
                                          ),
                                          decoration: BoxDecoration(
                                            color: tagBg,
                                            borderRadius: BorderRadius.circular(
                                              13,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.location_on,
                                            size: 12,
                                            color: tagClr,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // tagPill + kotaText
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // tagPill: borderRadius:20 px:10 py:7.5 marginTop:45
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 45,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 7.5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: tagBg,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            'Waktu Sholat',
                                            style: TextStyle(
                                              fontSize: 10,
                                              letterSpacing: 0.3,
                                              color: tagClr,
                                            ),
                                          ),
                                        ),
                                        // kotaText: fontSize:9 marginTop:3 opacity:0.85 right:2
                                        Transform.translate(
                                          offset: const Offset(-2, 0),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 3,
                                            ),
                                            child: Text(
                                              namaKota,
                                              style: TextStyle(
                                                fontSize: 9,
                                                letterSpacing: 0.3,
                                                color: tagClr.withOpacity(0.85),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // clockWrap: paddingHorizontal:18 paddingTop:4 marginTop:-23
                    Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18, top: 4),
                        child: Text(
                          jamSekarang,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                            color: clockClr,
                          ),
                        ),
                      ),
                    ),

                    // floatCard: absolute top:200 left:21 right:23 borderRadius:18 borderWidth:0.5 padding:20
                    Positioned(
                      top: 200,
                      left: 21,
                      right: 23,
                      child: Container(
                        decoration: BoxDecoration(
                          color: floatBg,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: floatBdr, width: 0.5),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // floatLabel: fontSize:10 letterSpacing:1
                                Text(
                                  'BERIKUTNYA',
                                  style: TextStyle(
                                    fontSize: 10,
                                    letterSpacing: 1,
                                    color: labelClr,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                // floatVal: fontSize:16 fontWeight:500 marginTop:2
                                Text(
                                  berikutnyaName.isEmpty
                                      ? '--'
                                      : berikutnyaName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: valClr,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // floatCd: fontSize:26 fontWeight:500 lineHeight:28
                                Text(
                                  formatCountdown(),
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500,
                                    height: 28 / 26,
                                    color: cdClr,
                                  ),
                                ),
                                // floatCdLabel: fontSize:10
                                Text(
                                  formatLabel(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: labelClr,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── GRID KARTU SHOLAT ────────────────────────────────────────
              // body: padding:20 paddingTop:125
              Expanded(
                child: loading
                    ? Center(
                        child: Text(
                          'Mengambil jadwal...',
                          style: TextStyle(color: labelClr),
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 125, 20, 20),
                        child: Wrap(
                          // grid: flexDirection:row flexWrap:wrap gap:10
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(sholatTimes.length, (i) {
                            final item = sholatTimes[i];
                            final isCur = i == activeIndex;
                            final isLast = i == sholatTimes.length - 1;
                            final cardW = isLast
                                ? double.infinity
                                : (MediaQuery.of(context).size.width -
                                          20 * 2 -
                                          10) /
                                      2;

                            return SizedBox(
                              width: cardW,
                              child: _SholatCard(
                                item: item,
                                isCur: isCur,
                                isDark: widget.isDark,
                                curBg: curBg,
                                cardBg: cardBg,
                                curBdr: curBdr,
                                cardBdr: cardBdr,
                                nameClr: nameClr,
                                timeClr: timeClr,
                                timeOff: timeOff,
                                barBg: barBg,
                                cdClr: cdClr,
                              ),
                            );
                          }),
                        ),
                      ),
              ),
            ],
          ),

          // ── DOCK ──────────────────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildDock(context, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildDock(BuildContext context, bool isDark) {
    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFD4AF37), // Emas Mustard
            Color(0xFFC6712C), // Orange Terakota
            Color(0xFF630D0D), // Maroon Gelap
          ],
          stops: [0.1, 0.5, 0.9],
        ),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            [
              {'icon': Icons.home, 'label': 'Home'},
              {'icon': Icons.search, 'label': 'Search'},
              {'icon': Icons.access_time, 'label': 'Time'},
              {'icon': Icons.explore, 'label': 'Kiblat'},
              {'icon': Icons.favorite, 'label': 'Health'},
            ].map((item) {
              final label = item['label'] as String;
              final isActive = label == 'Time';
              return GestureDetector(
                onTap: () {
                  if (label == 'Home') {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (r) => false,
                    );
                  } else if (label == 'Search') {
                    Navigator.pushNamed(context, '/search');
                  } else if (label == 'Kiblat') {
                    Navigator.pushNamed(context, '/kiblat');
                  } else if (label == 'Time' && !isActive) {
                    Navigator.pushNamed(context, '/waktu-sholat');
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: isActive
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      size: 24,
                    ),
                    if (isActive)
                      Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
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

class _SholatCard extends StatefulWidget {
  final Map<String, String> item;
  final bool isCur;
  final bool isDark;
  final Color curBg, cardBg, curBdr, cardBdr;
  final Color nameClr, timeClr, timeOff, barBg, cdClr;

  const _SholatCard({
    required this.item,
    required this.isCur,
    required this.isDark,
    required this.curBg,
    required this.cardBg,
    required this.curBdr,
    required this.cardBdr,
    required this.nameClr,
    required this.timeClr,
    required this.timeOff,
    required this.barBg,
    required this.cdClr,
  });

  @override
  State<_SholatCard> createState() => _SholatCardState();
}

class _SholatCardState extends State<_SholatCard>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _glowAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    setState(() => _pressed = true);
    _ctrl.forward();
  }

  void _onTapUp(_) {
    setState(() => _pressed = false);
    _ctrl.reverse();
  }

  void _onTapCancel() {
    setState(() => _pressed = false);
    _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, child) {
          return Transform.scale(
            scale: _scaleAnim.value,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _pressed
                    ? (widget.isCur
                          ? widget.curBg
                          : (widget.isDark
                                ? const Color(0xFF2A2A2A)
                                : const Color(0xFFFFFBF0)))
                    : (widget.isCur ? widget.curBg : widget.cardBg),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: widget.isCur ? widget.curBdr : widget.cardBdr,
                  width: widget.isCur ? 1 : 0.5,
                ),
                boxShadow: _pressed
                    ? [
                        BoxShadow(
                          color: const Color(
                            0xFFD4A017,
                          ).withOpacity(0.25 * _glowAnim.value),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item['name']!.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1,
                      color: widget.nameClr,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item['time']!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: widget.isCur ? widget.timeClr : widget.timeOff,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: widget.barBg,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: widget.isCur
                        ? FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.68,
                            child: Container(
                              decoration: BoxDecoration(
                                color: widget.cdClr,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
