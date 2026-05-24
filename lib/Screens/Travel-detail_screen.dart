import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application/config.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ─── TEMA: Gold / Cream Elegan ────────────────────────────────────────────────
const Color kCream      = Color(0xFFFBF7EE);   // background utama
const Color kCreamDeep  = Color(0xFFF2EAD3);   // background card / section
const Color kCreamBorder= Color(0xFFE8D9B5);   // border halus
const Color kGold       = Color(0xFFBF9B30);   // gold utama (gelap agar kontras)
const Color kGoldLight  = Color(0xFFD4AF37);   // gold menengah
const Color kGoldBright = Color(0xFFF5C842);   // gold terang (highlight)
const Color kGoldShimmer= Color(0xFFFAE27C);   // shimmer bar
const Color kDark       = Color(0xFF2C1A00);   // teks utama (coklat sangat gelap)
const Color kMuted      = Color(0xFF7A6040);   // teks sekunder

// ─── HELPER ──────────────────────────────────────────────────────────────────
Future<void> _openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

String _toWaNumber(String raw) {
  String number = raw.replaceAll(RegExp(r'[^0-9]'), '');

  if (number.startsWith('0')) {
    number = '62${number.substring(1)}';
  }

  if (!number.startsWith('62')) {
    number = '62$number';
  }

  return number;
}

// ─── MODEL ───────────────────────────────────────────────────────────────────
class TravelDetail {
  final int id;
  final String nama;
  final String? logo, deskripsi, alamat, email, telepon;
  final String? nomorSkUmrah, nomorSkHaji;
  final int? jumlahJamaah, jumlahPaket;
  final String? izinKemenag;
  final List<String> galeri;

  TravelDetail({
    required this.id,
    required this.nama,
    this.logo,
    this.deskripsi,
    this.alamat,
    this.email,
    this.telepon,
    this.nomorSkUmrah,
    this.nomorSkHaji,
    this.jumlahJamaah,
    this.jumlahPaket,
    this.izinKemenag,
    this.galeri = const [],
  });

  factory TravelDetail.fromJson(Map<String, dynamic> j) {
    List<String> galeriList = [];
    final raw = j['galeri'];
    if (raw != null) {
      if (raw is List) {
        for (final e in raw) {
          if (e is String && e.isNotEmpty) {
            galeriList.add(e);
          } else if (e is Map) {
            final url = e['url'] ?? e['path'] ?? e['foto'] ?? e['image'];
            if (url != null && url.toString().isNotEmpty) {
              galeriList.add(url.toString());
            }
          }
        }
      } else if (raw is String && raw.isNotEmpty) {
        galeriList = raw.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
      }
    }
    return TravelDetail(
      id: j['id'],
      nama: j['nama_travel'] ?? '',
      logo: j['logo'],
      deskripsi: j['deskripsi'],
      alamat: j['alamat'],
      email: j['email'],
      telepon: j['nomor_telepon'] ?? j['telepon'] ?? j['whatsapp'] ?? j['no_hp'],
      nomorSkUmrah: j['nomor_sk_umrah'],
      nomorSkHaji: j['nomor_sk_haji'],
      jumlahJamaah: j['jumlah_jamaah'],
      jumlahPaket: j['jumlah_paket'],
      izinKemenag: j['izin_kemenag'],
      galeri: galeriList,
    );
  }
}

// ─── SERVICE ─────────────────────────────────────────────────────────────────
class TravelDetailService {
  static const String _userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36';

  static Future<Map<String, String>> _solveChallenge(String url) async {
    final firstResponse = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': _userAgent},
    );
    final html = firstResponse.body;
    if (!html.contains('slowAES')) return {};

    final regA = RegExp(r'a=toNumbers\("([a-f0-9]+)"\)');
    final regB = RegExp(r'b=toNumbers\("([a-f0-9]+)"\)');
    final regC = RegExp(r'c=toNumbers\("([a-f0-9]+)"\)');

    final a = regA.firstMatch(html)?.group(1) ?? '';
    final b = regB.firstMatch(html)?.group(1) ?? '';
    final c = regC.firstMatch(html)?.group(1) ?? '';

    final key        = enc.Key.fromBase16(a);
    final iv         = enc.IV.fromBase16(b);
    final ciphertext = enc.Encrypted.fromBase16(c);
    final encrypter  = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc, padding: null));
    final decrypted  = encrypter.decryptBytes(ciphertext, iv: iv);
    final cookieValue = decrypted.map((b) => b.toRadixString(16).padLeft(2, '0')).join('');
    return {'__test': cookieValue};
  }

  static Future<TravelDetail> getDetail(int id) async {
    final targetUrl = '$BASE_URL/api/travel/$id';
    final cookies   = await _solveChallenge(targetUrl);
    final cookieHeader = cookies.entries.map((e) => '${e.key}=${e.value}').join('; ');
    final response  = await http.get(
      Uri.parse('$targetUrl?i=1'),
      headers: {
        'Accept': 'application/json',
        'Cookie': cookieHeader,
        'User-Agent': _userAgent,
      },
    );
    if (response.statusCode == 200) return TravelDetail.fromJson(jsonDecode(response.body));
    throw Exception('Gagal load detail: ${response.statusCode}');
  }
}

// ─── SCREEN ──────────────────────────────────────────────────────────────────
class TravelDetailScreen extends StatefulWidget {
  final int travelId;
  const TravelDetailScreen({super.key, required this.travelId});

  @override
  State<TravelDetailScreen> createState() => _TravelDetailScreenState();
}

class _TravelDetailScreenState extends State<TravelDetailScreen> {
  TravelDetail? detail;
  bool   isLoading = true;
  String error     = '';
  int    _lightboxIndex = 0;
  bool   _lightboxOpen  = false;
  late   PageController _pageCtrl;
  Future<void> _load() async {
    try {
      final d = await TravelDetailService.getDetail(widget.travelId);

      setState(() {
        detail = d;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController();
    _load();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  Future<void> _openUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);

      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw 'Tidak bisa membuka url';
      }
    } catch (e) {
      debugPrint('Error membuka URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      body: isLoading
          ? _buildLoader()
          : error.isNotEmpty
          ? _buildError()
          : Stack(children: [
        _buildScrollContent(),
        if (_lightboxOpen) _buildLightbox(),
        if (!_lightboxOpen) _buildWAFloat(),
      ]),
    );
  }

  Widget _buildLoader() => Container(
    color: kCream,
    child: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const CircularProgressIndicator(color: kGold),
        const SizedBox(height: 16),
        Text('Memuat data travel...',
            style: TextStyle(color: kMuted.withOpacity(0.8), fontSize: 13)),
      ]),
    ),
  );

  Widget _buildError() => Container(
    color: kCream,
    padding: const EdgeInsets.all(24),
    child: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.error_outline, color: kGold, size: 48),
        const SizedBox(height: 12),
        Text(error,
            textAlign: TextAlign.center,
            style: const TextStyle(color: kMuted, fontSize: 13)),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            setState(() { isLoading = true; error = ''; });
            _load();
          },
          child: const Text('Coba lagi',
              style: TextStyle(color: kGold, fontWeight: FontWeight.w700)),
        ),
      ]),
    ),
  );

  Widget _buildScrollContent() {
    return CustomScrollView(
      slivers: [
        _buildHero(),
        SliverToBoxAdapter(child: _buildStats()),
        SliverToBoxAdapter(child: _buildDescSection()),
        if (detail!.alamat != null && detail!.alamat!.isNotEmpty)
          SliverToBoxAdapter(child: _buildMapCard()),
        SliverToBoxAdapter(child: _buildInfoCard()),
        SliverToBoxAdapter(child: _buildGaleri()),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  // ── HERO ───────────────────────────────────────────────────────────────────
  Widget _buildHero() {
    final heroImg = detail!.galeri.isNotEmpty ? detail!.galeri[0] : null;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 240,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Foto latar
            if (heroImg != null)
              Image.network(heroImg, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: kCreamDeep))
            else
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kCreamDeep, kCream],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

            // Overlay cream gradient dari bawah
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x00000000), Color(0xE0000000)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            // Gold shimmer bar atas
            Positioned(
              top: 0, left: 0, right: 0,
              child: Container(
                height: 3,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kGold, kGoldBright, kGoldShimmer, kGoldBright, kGold],
                  ),
                ),
              ),
            ),

            // Tombol back
            Positioned(
              top: 50, left: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: kCream.withOpacity(0.85),
                    shape: BoxShape.circle,
                    border: Border.all(color: kGold, width: 1.2),
                    boxShadow: [
                      BoxShadow(color: kGold.withOpacity(0.25), blurRadius: 6),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: kGold, size: 15),
                ),
              ),
            ),

            // Logo + nama (bawah kiri)
            Positioned(
              bottom: 22, left: 16, right: 16,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Logo bulat dengan border gold
                  Container(
                    width: 62, height: 62,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kGoldBright, width: 2.5),
                      color: kCreamDeep,
                      boxShadow: [
                        BoxShadow(
                            color: kGold.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 1),
                      ],
                    ),
                    child: ClipOval(
                      child: detail!.logo != null && detail!.logo!.isNotEmpty
                          ? Image.network(detail!.logo!, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.mosque, color: kGold, size: 28))
                          : const Icon(Icons.mosque, color: kGold, size: 28),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          detail!.nama.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(color: Colors.black54, blurRadius: 6),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 3),
                          decoration: BoxDecoration(
                            color: kGold.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'WUJUDKAN PANGGILAN IBADAH ANDA',
                            style: TextStyle(
                              color: kCream,
                              fontSize: 8,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── STATS ──────────────────────────────────────────────────────────────────
  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _statCard(
              icon: Icons.group_outlined,
              value: '${detail!.jumlahJamaah ?? 0}++',
              label: 'Jamaah',
              desc: 'Telah melayani ribuan jamaah dengan aman.',
            )),
            const SizedBox(width: 8),
            Expanded(child: _statCard(
              icon: Icons.verified_outlined,
              value: 'Izin Resmi',
              label: 'Kemenag',
              desc: 'Berizin resmi identifikasi A.',
            )),
            const SizedBox(width: 8),
            Expanded(child: _statCard(
              icon: Icons.luggage_outlined,
              value: '${detail!.jumlahPaket ?? 0}',
              label: 'Paket',
              desc: 'Pilihan paket ibadah tersedia.',
            )),
          ],
        ),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kCreamBorder, width: 1),
        boxShadow: [
          BoxShadow(color: kGold.withOpacity(0.10), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              color: kGoldShimmer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: kGold, size: 16),
          ),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w800, color: kDark)),
          Text(label,
              style: const TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: kGold)),
          const SizedBox(height: 4),
          Text(desc,
              style: TextStyle(fontSize: 9, color: kMuted.withOpacity(0.7), height: 1.5)),
        ],
      ),
    );
  }

  // ── DESKRIPSI ──────────────────────────────────────────────────────────────
  Widget _buildDescSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: _creamCard(
        title: 'Deskripsi Perusahaan',
        child: Text(
          detail!.deskripsi ?? 'Deskripsi belum tersedia.',
          style: const TextStyle(fontSize: 12, color: kMuted, height: 1.75),
        ),
      ),
    );
  }

  // ── MAP CARD ───────────────────────────────────────────────────────────────
  Widget _buildMapCard() {
    final alamat = detail!.alamat ?? '';

    final mapsUrl =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(alamat)}';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: GestureDetector(
        onTap: () => _openUrl(mapsUrl),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFF8E7),
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: kCreamBorder),
            boxShadow: [
              BoxShadow(
                color: kGold.withOpacity(0.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 170,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: Stack(
                    children: [
                      FlutterMap(
                        options: const MapOptions(
                          initialCenter: LatLng(-6.200000, 106.816666),
                          initialZoom: 13,
                          interactionOptions: InteractionOptions(
                            flags: InteractiveFlag.none,
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                            'https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),

                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(-6.200000, 106.816666),
                                width: 50,
                                height: 50,
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.45),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Buka di Google Maps',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: kGold.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.map,
                        color: kGold,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail!.nama,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: kDark,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            alamat,
                            style: const TextStyle(
                              fontSize: 12,
                              color: kMuted,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── INFO CARD ──────────────────────────────────────────────────────────────
  Widget _buildInfoCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: _creamCard(
        title: 'Informasi Travel',
        child: Column(children: [
          _infoRow(Icons.business_outlined,     'Nama Perusahaan', detail!.nama),
          _infoRow(Icons.phone_outlined,        'Nomor Telepon',   detail!.telepon      ?? '-'),
          _infoRow(Icons.email_outlined,        'Alamat Email',    detail!.email        ?? '-'),
          _infoRow(Icons.article_outlined,      'Nomor SK Umrah',  detail!.nomorSkUmrah ?? '-'),
          _infoRow(Icons.article_outlined,      'Nomor SK Haji',   detail!.nomorSkHaji  ?? '-'),
        ]),
      ),
    );
  }

  // ── GALERI ─────────────────────────────────────────────────────────────────
  Widget _buildGaleri() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(width: 3, height: 16,
                decoration: BoxDecoration(
                    color: kGold, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 8),
            const Text('Galeri Travel',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: kDark)),
          ]),
          const SizedBox(height: 3),
          const Padding(
            padding: EdgeInsets.only(left: 11),
            child: Text('Dokumentasi perjalanan dan kebersamaan jamaah',
                style: TextStyle(fontSize: 12, color: kMuted)),
          ),
          const SizedBox(height: 12),
          if (detail!.galeri.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: kCreamBorder),
              ),
              child: Column(children: [
                Icon(Icons.photo_library_outlined,
                    color: kGold.withOpacity(0.5), size: 36),
                const SizedBox(height: 8),
                const Text('Belum ada foto galeri',
                    style: TextStyle(color: kMuted, fontSize: 13)),
              ]),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: detail!.galeri.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() { _lightboxIndex = index; _lightboxOpen = true; });
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_pageCtrl.hasClients) _pageCtrl.jumpToPage(index);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kCreamBorder, width: 1),
                    boxShadow: [
                      BoxShadow(
                          color: kGold.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 2)),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          detail!.galeri[index],
                          fit: BoxFit.cover,
                          loadingBuilder: (_, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              color: kCreamDeep,
                              child: const Center(
                                child: CircularProgressIndicator(
                                    color: kGold, strokeWidth: 2),
                              ),
                            );
                          },
                          errorBuilder: (_, __, ___) => Container(
                            color: kCreamDeep,
                            child: Icon(Icons.broken_image,
                                size: 32, color: kGold.withOpacity(0.4)),
                          ),
                        ),
                        // Gradient bawah tipis
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                kDark.withOpacity(0.45),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        // Zoom badge gold
                        Positioned(
                          bottom: 8, right: 8,
                          child: Container(
                            width: 28, height: 28,
                            decoration: BoxDecoration(
                              color: kGold,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: kGold.withOpacity(0.4),
                                    blurRadius: 6),
                              ],
                            ),
                            child: const Icon(Icons.zoom_in,
                                color: Colors.white, size: 16),
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
    );
  }

  // ── LIGHTBOX ───────────────────────────────────────────────────────────────
  Widget _buildLightbox() {
    final photos = detail!.galeri;
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => setState(() => _lightboxOpen = false),
          child: Container(
            color: Colors.black.withOpacity(0.92),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tombol tutup
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 14),
                      child: GestureDetector(
                        onTap: () => setState(() => _lightboxOpen = false),
                        child: Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: kCreamDeep,
                            shape: BoxShape.circle,
                            border: Border.all(color: kGold, width: 1.2),
                          ),
                          child: const Icon(Icons.close, color: kGold, size: 18),
                        ),
                      ),
                    ),
                  ),

                  // PageView gambar
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.52,
                      child: PageView.builder(
                        controller: _pageCtrl,
                        itemCount: photos.length,
                        onPageChanged: (i) => setState(() => _lightboxIndex = i),
                        itemBuilder: (_, i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.network(
                              photos[i],
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Center(
                                child: Icon(Icons.broken_image,
                                    color: kGold.withOpacity(0.5), size: 60),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Nav
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _navBtn(
                          icon: Icons.chevron_left,
                          enabled: _lightboxIndex > 0,
                          onTap: () => _pageCtrl.previousPage(
                              duration: const Duration(milliseconds: 280),
                              curve: Curves.easeInOut),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 7),
                          decoration: BoxDecoration(
                            color: kGold,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_lightboxIndex + 1} / ${photos.length}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(width: 20),
                        _navBtn(
                          icon: Icons.chevron_right,
                          enabled: _lightboxIndex < photos.length - 1,
                          onTap: () => _pageCtrl.nextPage(
                              duration: const Duration(milliseconds: 280),
                              curve: Curves.easeInOut),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Dots
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(photos.length, (i) {
                        final active = i == _lightboxIndex;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: active ? 20 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: active ? kGoldBright : Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navBtn({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        opacity: enabled ? 1.0 : 0.25,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            color: kCreamDeep,
            shape: BoxShape.circle,
            border: Border.all(color: enabled ? kGold : Colors.white24, width: 1.5),
          ),
          child: Icon(icon, color: kGold, size: 26),
        ),
      ),
    );
  }

  // ── WA FLOAT ───────────────────────────────────────────────────────────────
  Widget _buildWAFloat() {
    final hasPhone =
        detail?.telepon != null && detail!.telepon!.trim().isNotEmpty;

    return Positioned(
      bottom: 24,
      right: 20,
      child: GestureDetector(
        onTap: hasPhone
            ? () async {
          final number = _toWaNumber(detail!.telepon!);

          final url = 'https://wa.me/$number';

          await _openUrl(url);
        }
            : null,
        child: Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF25D366),
                Color(0xFF1EBE5D),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.45),
                blurRadius: 18,
                spreadRadius: 3,
              ),
            ],
          ),
          child: const Icon(
            Icons.chat,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  // ── SHARED ─────────────────────────────────────────────────────────────────
  Widget _creamCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kCreamBorder, width: 1),
        boxShadow: [
          BoxShadow(
              color: kGold.withOpacity(0.10),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gold shimmer top bar
          Container(
            height: 2.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kGold, kGoldBright, kGoldShimmer, kGoldBright, kGold],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 3, height: 14,
                    decoration: BoxDecoration(
                      color: kGold,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(title.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: kGold,
                          letterSpacing: 1.2)),
                ]),
                Divider(color: kCreamBorder, height: 18),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: kGoldShimmer.withOpacity(0.25),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kCreamBorder, width: 1),
            ),
            child: Icon(icon, size: 16, color: kGold),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(fontSize: 10, color: kMuted.withOpacity(0.7))),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: kDark),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}