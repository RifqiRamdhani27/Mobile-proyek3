import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

const Color kGold = Color(0xFFF5B400);
const Color kGoldLight = Color(0xFFFFF8E1);
const Color kGoldDark = Color(0xFFD4A017);
const Color kDark = Color(0xFF1A2744);

// ─── MODEL DETAIL ─────────────────────────────────────────────────────────────
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
    this.logo, this.deskripsi, this.alamat, this.email, this.telepon,
    this.nomorSkUmrah, this.nomorSkHaji,
    this.jumlahJamaah, this.jumlahPaket, this.izinKemenag,
    this.galeri = const [],
  });

  factory TravelDetail.fromJson(Map<String, dynamic> j) {
    List<String> galeriList = [];
    if (j['galeri'] != null) {
      galeriList = (j['galeri'] as List)
          .map((e) => e.toString())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return TravelDetail(
      id: j['id'],
      nama: j['nama_travel'] ?? '',
      logo: j['logo'],
      deskripsi: j['deskripsi'],
      alamat: j['alamat'],
      email: j['email'],
      telepon: j['nomor_telepon'],
      nomorSkUmrah: j['nomor_sk_umrah'],
      nomorSkHaji: j['nomor_sk_haji'],
      jumlahJamaah: j['jumlah_jamaah'],
      jumlahPaket: j['jumlah_paket'],
      izinKemenag: j['izin_kemenag'],
      galeri: galeriList,
    );
  }
}

// ─── SERVICE ──────────────────────────────────────────────────────────────────
class TravelDetailService {
  static const baseUrl = 'http://127.0.0.1:8000';

  static Future<TravelDetail> getDetail(int id) async {
    final res = await http.get(
      Uri.parse('$baseUrl/api/travel/$id'),
      headers: {'Accept': 'application/json'},
    );
    if (res.statusCode == 200) {
      return TravelDetail.fromJson(jsonDecode(res.body));
    }
    throw Exception('Gagal load detail: ${res.statusCode}');
  }
}

// ─── SCREEN ───────────────────────────────────────────────────────────────────
class TravelDetailScreen extends StatefulWidget {
  final int travelId;
  const TravelDetailScreen({super.key, required this.travelId});

  @override
  State<TravelDetailScreen> createState() => _TravelDetailScreenState();
}

class _TravelDetailScreenState extends State<TravelDetailScreen> {
  TravelDetail? detail;
  bool isLoading = true;
  String error = '';
  int _lightboxIndex = 0;
  bool _lightboxOpen = false;
  final PageController _pageCtrl = PageController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final d = await TravelDetailService.getDetail(widget.travelId);
      setState(() { detail = d; isLoading = false; });
    } catch (e) {
      setState(() { error = e.toString(); isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F8),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: kGold))
          : error.isNotEmpty
              ? Center(child: Text(error, style: const TextStyle(color: Colors.grey)))
              : Stack(children: [
                  CustomScrollView(slivers: [
                    _buildHero(),
                    SliverToBoxAdapter(child: _buildBackBtn()),
                    SliverToBoxAdapter(child: _buildStats()),
                    SliverToBoxAdapter(child: _buildDescAndInfo()),
                    if (detail!.galeri.isNotEmpty)
                      SliverToBoxAdapter(child: _buildGaleri()),
                    const SliverToBoxAdapter(child: SizedBox(height: 80)),
                  ]),
                  if (_lightboxOpen) _buildLightbox(),
                  if (detail!.telepon != null && detail!.telepon!.isNotEmpty)
                    _buildWAFloat(),
                ]),
    );
  }

  // ─── HERO ───────────────────────────────────────────────────────────────────
  Widget _buildHero() {
    final heroImg = detail!.galeri.isNotEmpty ? detail!.galeri[0] : null;
    return SliverToBoxAdapter(
      child: Container(
        height: 240,
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          image: DecorationImage(
            image: heroImg != null
                ? NetworkImage(heroImg) as ImageProvider
                : const AssetImage('assets/images/travel_back.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.5),
                const Color(0xFF1E1400).withOpacity(0.78),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  detail!.nama.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'WUJUDKAN PANGGILAN IBADAH ANDA',
                  style: TextStyle(
                    color: Color(0xFFFFD166),
                    fontSize: 10,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                // dots
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _dot(true), _dot(false), _dot(false),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: active ? 22 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active ? const Color(0xFFFFD166) : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  // ─── BACK BUTTON ────────────────────────────────────────────────────────────
  Widget _buildBackBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: kGold,
              shape: BoxShape.circle,
              border: Border.all(color: kDark, width: 2),
            ),
            child: const Icon(Icons.chevron_left, color: kDark, size: 26),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: kGold,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: kDark, width: 2),
            ),
            child: const Text('Detail Travel',
                style: TextStyle(
                    color: kDark, fontWeight: FontWeight.w700, fontSize: 14)),
          ),
        ),
      ]),
    );
  }

  // ─── STATS CARDS ────────────────────────────────────────────────────────────
  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 36, 20, 16),
      child: Row(children: [
        Expanded(child: _statCard(
          icon: Icons.group,
          value: '${detail!.jumlahJamaah ?? 0}++ Jamaah',
          desc: 'Telah melayani ribuan jamaah umroh dan haji dengan aman.',
        )),
        const SizedBox(width: 10),
        Expanded(child: _statCard(
          icon: Icons.verified_user,
          value: 'Izin Resmi Kemenag',
          desc: 'Berizin resmi dengan identifikasi A.',
        )),
        const SizedBox(width: 10),
        Expanded(child: _statCard(
          icon: Icons.card_travel,
          value: '${detail!.jumlahPaket ?? 0} Paket',
          desc: 'Pilihan paket ibadah yang tersedia.',
        )),
      ]),
    );
  }

  Widget _statCard({required IconData icon, required String value, required String desc}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 36, 12, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kGold, width: 1.5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value,
            style: const TextStyle(
                fontSize: 11, fontWeight: FontWeight.w800, color: kDark)),
        const SizedBox(height: 6),
        Text(desc,
            style: const TextStyle(fontSize: 10, color: kDark, height: 1.6)),
      ]),
    );
  }

  // ─── DESC + INFO ────────────────────────────────────────────────────────────
  Widget _buildDescAndInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        // Desc card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEEEEEE)),
            boxShadow: [BoxShadow(color: kGold.withOpacity(0.08), blurRadius: 12)],
          ),
          child: Column(children: [
            // Logo + description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Logo circle
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kGold, width: 3),
                    boxShadow: [BoxShadow(color: kGold.withOpacity(0.3), blurRadius: 12)],
                  ),
                  child: ClipOval(
                    child: detail!.logo != null && detail!.logo!.isNotEmpty
                        ? Image.network(detail!.logo!, fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: kGoldLight,
                              child: const Icon(Icons.mosque, color: kGold, size: 36)))
                        : Container(
                            color: kGoldLight,
                            child: const Icon(Icons.mosque, color: kGold, size: 36)),
                  ),
                ),
                const SizedBox(width: 14),
                // Pink desc box
                Expanded(child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF5F5), Color(0xFFFDE8E8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red.withOpacity(0.08)),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      height: 2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFF5A0A0), Color(0xFFF5C0A0), Color(0xFFF5E0A0)]),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('DESKRIPSI PERUSAHAAN',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w800,
                            color: kDark, letterSpacing: 1)),
                    const SizedBox(height: 6),
                    Text(
                      detail!.deskripsi ?? 'Deskripsi perusahaan belum tersedia.',
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF4A5068), height: 1.7)),
                  ]),
                )),
              ]),
            ),
            // Map
            if (detail!.alamat != null && detail!.alamat!.isNotEmpty)
              _buildMap(),
          ]),
        ),

        const SizedBox(height: 14),

        // Info card
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xFFFFFCF4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEEEEEE)),
            boxShadow: [BoxShadow(color: kGold.withOpacity(0.08), blurRadius: 12)],
          ),
          child: Column(children: [
            // Gold top bar
            Container(height: 3,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD166), Color(0xFFF5A623), Color(0xFFD4860A)]),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFFFD166), Color(0xFFF5A623), Color(0xFFD4860A)],
                  ).createShader(bounds),
                  child: const Text('INFORMASI TRAVEL',
                      style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w900,
                          color: Colors.white, letterSpacing: 1.5)),
                ),
                const Divider(color: Color(0x33F5A623), height: 20),
                _infoRow(Icons.business, 'Nama Perusahaan', detail!.nama),
                _infoRow(Icons.phone, 'Nomor Telepon', detail!.telepon ?? '-'),
                _infoRow(Icons.email, 'Alamat Email', detail!.email ?? '-'),
                _infoRow(Icons.description, 'Nomor SK Umrah', detail!.nomorSkUmrah ?? '-'),
                _infoRow(Icons.description_outlined, 'Nomor SK Haji', detail!.nomorSkHaji ?? '-'),
              ]),
            ),
          ]),
        ),
        const SizedBox(height: 14),
      ]),
    );
  }

  Widget _buildMap() {
    final encoded = Uri.encodeComponent(detail!.alamat ?? '');
    final mapUrl =
        'https://maps.google.com/maps?q=$encoded&z=15&output=embed&hl=id';
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        color: Color(0xFFF8F9FE),
      ),
      child: Column(children: [
        const Divider(height: 1, color: Color(0xFFEEEEEE)),
        Row(children: [
          // Map placeholder with link
          GestureDetector(
            onTap: () async {
              final uri = Uri.parse(
                  'https://maps.google.com/?q=${Uri.encodeComponent(detail!.alamat ?? '')}');
              if (await canLaunchUrl(uri)) launchUrl(uri);
            },
            child: Container(
              width: 140, height: 110,
              color: const Color(0xFFE8ECF0),
              child: Stack(alignment: Alignment.center, children: [
                const Icon(Icons.map, size: 40, color: Color(0xFFBBBBBB)),
                Positioned(
                  bottom: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
                    ),
                    child: Row(children: const [
                      Icon(Icons.open_in_new, size: 10, color: Colors.blue),
                      SizedBox(width: 4),
                      Text('Maps', style: TextStyle(fontSize: 10, color: Colors.blue, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),
              ]),
            ),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(detail!.nama,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 12, color: kDark)),
              const SizedBox(height: 4),
              Text(detail!.alamat ?? '',
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF4A5068), height: 1.6)),
            ]),
          )),
        ]),
      ]),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Container(
          width: 30, height: 30,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD166), Color(0xFFF5A623), Color(0xFFD4860A)]),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: kGold.withOpacity(0.35), blurRadius: 8)],
          ),
          child: Icon(icon, size: 14, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: const TextStyle(fontSize: 10, color: Color(0xFF8892AA))),
          Text(value,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w700, color: kDark),
              overflow: TextOverflow.ellipsis, maxLines: 2),
        ])),
        const Divider(),
      ]),
    );
  }

  // ─── GALERI ─────────────────────────────────────────────────────────────────
  Widget _buildGaleri() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        // Section title with gradient
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Color(0xFF2C3E50), Color(0xFFD4A017), Color(0xFFF5A623)],
          ).createShader(b),
          child: const Text('GALERI KEBERSAMAAN',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w900,
                  letterSpacing: 2, color: Colors.white)),
        ),
        Container(
          width: 60, height: 3, margin: const EdgeInsets.only(top: 8, bottom: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD166), Color(0xFFF5A623), Color(0xFFD4860A)]),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 4 / 3,
          ),
          itemCount: detail!.galeri.length,
          itemBuilder: (ctx, i) => GestureDetector(
            onTap: () => setState(() {
              _lightboxIndex = i;
              _lightboxOpen = true;
            }),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(fit: StackFit.expand, children: [
                Image.network(
                  detail!.galeri[i],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: kGoldLight,
                    child: const Icon(Icons.image_not_supported, color: kGold)),
                ),
                // Hover overlay (always subtle)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.2),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                const Center(
                  child: Icon(Icons.zoom_in, color: Colors.white70, size: 28),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }

  // ─── LIGHTBOX ───────────────────────────────────────────────────────────────
  Widget _buildLightbox() {
    final photos = detail!.galeri;
    return GestureDetector(
      onTap: () => setState(() => _lightboxOpen = false),
      child: Container(
        color: Colors.black.withOpacity(0.92),
        child: Stack(alignment: Alignment.center, children: [
          // Image
          GestureDetector(
            onTap: () {},
            child: Image.network(
              photos[_lightboxIndex],
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, color: Colors.white, size: 60),
            ),
          ),
          // Counter
          Positioned(
            bottom: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('${_lightboxIndex + 1} / ${photos.length}',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ),
          // Close
          Positioned(
            top: 50, right: 20,
            child: GestureDetector(
              onTap: () => setState(() => _lightboxOpen = false),
              child: Container(
                width: 42, height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ),
          ),
          // Prev
          if (_lightboxIndex > 0)
            Positioned(
              left: 16,
              child: GestureDetector(
                onTap: () => setState(() => _lightboxIndex--),
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
                ),
              ),
            ),
          // Next
          if (_lightboxIndex < photos.length - 1)
            Positioned(
              right: 16,
              child: GestureDetector(
                onTap: () => setState(() => _lightboxIndex++),
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: const Icon(Icons.chevron_right, color: Colors.white, size: 28),
                ),
              ),
            ),
        ]),
      ),
    );
  }

  // ─── WA FLOAT ───────────────────────────────────────────────────────────────
  Widget _buildWAFloat() {
    return Positioned(
      bottom: 26, right: 22,
      child: GestureDetector(
        onTap: () async {
          final phone = detail!.telepon!.replaceAll(RegExp(r'[^0-9]'), '');
          final uri = Uri.parse('https://wa.me/$phone');
          if (await canLaunchUrl(uri)) launchUrl(uri);
        },
        child: Container(
          width: 54, height: 54,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2DEA6E), Color(0xFF25D366), Color(0xFF1DA851)]),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: const Color(0xFF25D366).withOpacity(0.5), blurRadius: 20, spreadRadius: 2),
            ],
          ),
          child: const Icon(Icons.chat, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}