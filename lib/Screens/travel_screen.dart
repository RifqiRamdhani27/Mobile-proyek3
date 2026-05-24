import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'travel-detail_screen.dart';
import 'ai_modal_widget.dart';
import 'chatbot.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/Screens/google_login_screen.dart';
import 'package:flutter_application/config.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:shared_preferences/shared_preferences.dart';

// ─── TEMA: Gold / Cream Elegan (sama dengan detail screen) ───────────────────
const Color kCream       = Color(0xFFFBF7EE);
const Color kCreamDeep   = Color(0xFFF2EAD3);
const Color kCreamBorder = Color(0xFFE8D9B5);
const Color kGold        = Color(0xFFBF9B30);
const Color kGoldLight   = Color(0xFFD4AF37);
const Color kGoldBright  = Color(0xFFF5C842);
const Color kGoldShimmer = Color(0xFFFAE27C);
const Color kDark        = Color(0xFF2C1A00);
const Color kMuted       = Color(0xFF7A6040);
const Color kGreen       = Color(0xFF10B981);

// ─── MODEL ───────────────────────────────────────────────────────────────────
class Travel {
  final int id;
  final String nama;
  final String? alamat, telepon, email, logo, nomorSkUmrah, nomorSkHaji;

  Travel({
    required this.id,
    required this.nama,
    this.alamat,
    this.telepon,
    this.email,
    this.logo,
    this.nomorSkUmrah,
    this.nomorSkHaji,
  });

  factory Travel.fromJson(Map<String, dynamic> json) => Travel(
    id: json['id'],
    nama: json['nama_travel'] ?? '',
    alamat: json['alamat'],
    telepon: json['nomor_telepon'],
    email: json['email'],
    logo: json['logo'],
    nomorSkUmrah: json['nomor_sk_umrah'],
    nomorSkHaji: json['nomor_sk_haji'],
  );
}

class NearbyTravel {
  final int id;
  final String nama;
  final String? alamat, logo, detailUrl;
  final double distanceKm;

  NearbyTravel({
    required this.id,
    required this.nama,
    required this.distanceKm,
    this.alamat,
    this.logo,
    this.detailUrl,
  });

  factory NearbyTravel.fromJson(Map<String, dynamic> json) => NearbyTravel(
    id: json['id'],
    nama: json['nama'] ?? '',
    distanceKm: (json['distance_km'] as num).toDouble(),
    alamat: json['alamat'],
    logo: json['logo'],
    detailUrl: json['detail_url'],
  );
}

// ─── SERVICE ─────────────────────────────────────────────────────────────────
class TravelService {
  static const String _userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36';

  static Future<Map<String, String>> _solveChallenge(String url) async {
    final firstResponse =
    await http.get(Uri.parse(url), headers: {'User-Agent': _userAgent});
    final html = firstResponse.body;
    if (!html.contains('slowAES')) return {};
    final a = RegExp(r'a=toNumbers\("([a-f0-9]+)"\)').firstMatch(html)?.group(1) ?? '';
    final b = RegExp(r'b=toNumbers\("([a-f0-9]+)"\)').firstMatch(html)?.group(1) ?? '';
    final c = RegExp(r'c=toNumbers\("([a-f0-9]+)"\)').firstMatch(html)?.group(1) ?? '';
    final key        = enc.Key.fromBase16(a);
    final iv         = enc.IV.fromBase16(b);
    final ciphertext = enc.Encrypted.fromBase16(c);
    final encrypter  = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc, padding: null));
    final decrypted  = encrypter.decryptBytes(ciphertext, iv: iv);
    return {'__test': decrypted.map((b) => b.toRadixString(16).padLeft(2, '0')).join('')};
  }

  static Future<List<Travel>> getTravels({String? search}) async {
    final targetUrl = '$BASE_URL/api/travel';
    final cookies   = await _solveChallenge(targetUrl);
    final cookieHeader = cookies.entries.map((e) => '${e.key}=${e.value}').join('; ');
    final uri = Uri.parse('$targetUrl?i=1').replace(queryParameters: {
      if (search != null && search.isNotEmpty) 'search': search,
      'i': '1',
    });
    final response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Cookie': cookieHeader,
      'User-Agent': _userAgent,
    });
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => Travel.fromJson(e))
          .toList();
    }
    throw Exception('Gagal load data (${response.statusCode})');
  }

  static Future<List<NearbyTravel>> getNearby({
    required double lat,
    required double lng,
    double radius = 50,
  }) async {
    final cookies = await _solveChallenge('$BASE_URL/api/travel');
    final cookieHeader = cookies.entries.map((e) => '${e.key}=${e.value}').join('; ');
    final pageRes = await http.get(Uri.parse('$BASE_URL/travel'), headers: {
      'User-Agent': _userAgent,
      'Cookie': cookieHeader,
      'Accept': 'text/html',
    });
    final html = pageRes.body;
    String? csrfToken =
        RegExp(r'name="csrf-token"\s+content="([^"]+)"').firstMatch(html)?.group(1) ??
            RegExp(r'name="_token"\s+value="([^"]+)"').firstMatch(html)?.group(1);
    if (csrfToken == null || csrfToken.isEmpty) throw Exception('CSRF token tidak ditemukan');

    final rawCookie = pageRes.headers['set-cookie'] ?? '';
    String laravelSession = RegExp(r'laravel_session=([^;]+)').firstMatch(rawCookie)?.group(1) ?? '';
    String xsrfToken      = RegExp(r'XSRF-TOKEN=([^;]+)').firstMatch(rawCookie)?.group(1) ?? '';

    final fullCookie = [
      cookieHeader,
      if (laravelSession.isNotEmpty) 'laravel_session=$laravelSession',
      if (xsrfToken.isNotEmpty) 'XSRF-TOKEN=$xsrfToken',
    ].join('; ');

    final response = await http.post(
      Uri.parse('$BASE_URL/travel/nearby?i=1'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': fullCookie,
        'User-Agent': _userAgent,
        'X-CSRF-TOKEN': csrfToken,
        'X-Requested-With': 'XMLHttpRequest',
        'Referer': '$BASE_URL/travel',
      },
      body: jsonEncode({'lat': lat, 'lng': lng, 'radius': radius}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['travels'] as List).map((e) => NearbyTravel.fromJson(e)).toList();
    }
    throw Exception('Gagal mencari travel terdekat (status: ${response.statusCode})');
  }
}

// ─── ARCH CLIPPER (bentuk lengkung atas masjid) ───────────────────────────────
class _MasjidArchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Mulai dari kiri bawah
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.32);
    // Lengkung kiri menuju puncak
    path.cubicTo(
      0, size.height * 0.02,
      size.width * 0.18, 0,
      size.width * 0.5, 0,
    );
    // Lengkung kanan dari puncak
    path.cubicTo(
      size.width * 0.82, 0,
      size.width, size.height * 0.02,
      size.width, size.height * 0.32,
    );
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

// ─── SCREEN ──────────────────────────────────────────────────────────────────
class TravelScreen extends StatefulWidget {
  const TravelScreen({super.key});

  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  List<Travel> travels     = [];
  bool   isLoading         = true;
  bool   chatOpen          = false;
  String error             = '';
  String activeFilter      = 'Semua Paket';
  Set<int> favorites       = {};
  Set<int> nearbyIds       = {};
  bool   isNearbyLoading   = false;
  final  _searchCtrl       = TextEditingController();
  final  filters           = ['Semua Paket', 'Umrah', 'Haji'];

  bool get _isLoggedIn => userNotifier.value != null;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    if (_isLoggedIn) {
      fetchData();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => _goToLogin());
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites.map((e) => e.toString()).toList());
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favorites');
    if (favList != null) {
      setState(() => favorites = favList.map((e) => int.parse(e)).toSet());
    }
  }

  Future<void> _goToLogin() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (_) => GoogleLoginScreen(isDark: false)));
    if (userNotifier.value != null) {
      fetchData();
    } else {
      if (mounted) Navigator.pop(context);
    }
  }

  Future<void> fetchData({String? search}) async {
    setState(() => isLoading = true);
    try {
      final data = await TravelService.getTravels(search: search);
      setState(() { travels = data; isLoading = false; error = ''; });
    } catch (e) {
      setState(() { error = e.toString(); isLoading = false; });
    }
  }

  Future<void> _cariTerdekat() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Izin lokasi ditolak. Aktifkan GPS di pengaturan.'),
          backgroundColor: Colors.red,
        ));
      }
      return;
    }
    setState(() => isNearbyLoading = true);
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      final results = await TravelService.getNearby(
          lat: pos.latitude, lng: pos.longitude, radius: 50);
      setState(() { nearbyIds = results.map((t) => t.id).toSet(); isNearbyLoading = false; });
      if (!mounted) return;
      _showNearbyBottomSheet(results);
    } catch (e) {
      setState(() => isNearbyLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal: ${e.toString()}'), backgroundColor: Colors.red));
      }
    }
  }

  void _showBookmarks() {
    final bookmarkedTravels = travels.where((t) => favorites.contains(t.id)).toList();
    showModalBottomSheet(
      context: context,
      backgroundColor: kCream,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: kCreamBorder, borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 16),
            // Gold bar
            Container(height: 2,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kGold, kGoldBright, kGoldShimmer, kGoldBright, kGold]),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
              child: Row(children: [
                Container(width: 3, height: 16,
                    decoration: BoxDecoration(color: kGold,
                        borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: 8),
                const Text('Travel Tersimpan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kDark)),
              ]),
            ),
            bookmarkedTravels.isEmpty
                ? const Padding(
              padding: EdgeInsets.all(32),
              child: Text('Belum ada travel disimpan',
                  style: TextStyle(fontSize: 14, color: kMuted)),
            )
                : SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: bookmarkedTravels.length,
                itemBuilder: (_, i) {
                  final t = bookmarkedTravels[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: kCreamDeep,
                      child: const Icon(Icons.mosque, color: kGold),
                    ),
                    title: Text(t.nama,
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: kDark, fontWeight: FontWeight.w600)),
                    subtitle: Text(t.alamat ?? '-',
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: kMuted, fontSize: 11)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: kGold),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => TravelDetailScreen(travelId: t.id)));
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  void _showNearbyBottomSheet(List<NearbyTravel> results) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _NearbyBottomSheet(
        results: results,
        onSelectTravel: (id) => Navigator.push(context,
            MaterialPageRoute(builder: (_) => TravelDetailScreen(travelId: id))),
      ),
    );
  }

  // ── BUILD ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder<UserSession?>(
        valueListenable: userNotifier,
        builder: (context, user, _) {
          if (user == null) {
            return const Center(child: CircularProgressIndicator(color: kGold));
          }
          return Stack(children: [
            CustomScrollView(slivers: [
              _buildHero(user),
              _buildFilter(),
              if (isLoading)
                const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator(color: kGold)))
              else if (error.isNotEmpty)
                SliverFillRemaining(child: _buildError())
              else
                _buildGrid(),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ]),
            _buildFloatingButtons(),
            if (chatOpen) _buildChatbot(),
          ]);
        },
      ),
    );
  }

  // ── HERO ──────────────────────────────────────────────────────────────────
  Widget _buildHero(UserSession? user) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Stack(children: [
          // Background foto
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Image.asset(
              'assets/images/travel_back.png',
              height: 430,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Overlay cream gelap
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Container(
              height: 430,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.55),
                    kDark.withOpacity(0.70),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Gold shimmer bar atas
          Positioned(
            top: 0, left: 0, right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
              child: Container(
                height: 3,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kGold, kGoldBright, kGoldShimmer, kGoldBright, kGold],
                  ),
                ),
              ),
            ),
          ),
          // Konten
          SizedBox(
            height: 430,
            child: SafeArea(
              child: Column(
                children: [
                  // Top bar: back + bookmark
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: kCream.withOpacity(0.15),
                              shape: BoxShape.circle,
                              border: Border.all(color: kGoldBright.withOpacity(0.5), width: 1),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new,
                                color: kGoldShimmer, size: 15),
                          ),
                        ),
                        GestureDetector(
                          onTap: _showBookmarks,
                          child: Stack(children: [
                            Container(
                              width: 38, height: 38,
                              decoration: BoxDecoration(
                                color: kCream.withOpacity(0.15),
                                shape: BoxShape.circle,
                                border: Border.all(color: kGoldBright.withOpacity(0.5), width: 1),
                              ),
                              child: const Icon(Icons.bookmark, color: kGoldShimmer, size: 18),
                            ),
                            if (favorites.isNotEmpty)
                              Positioned(
                                right: 0, top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      color: Colors.red, shape: BoxShape.circle),
                                  child: Text(favorites.length.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 9,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  // Judul
                  const SizedBox(height: 8),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [kGold, kGoldBright, kGoldShimmer],
                    ).createShader(bounds),
                    child: const Text('TRAVEL',
                        style: TextStyle(
                            fontSize: 42, fontWeight: FontWeight.w900,
                            color: Colors.white, letterSpacing: 8)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Temukan Travel Umrah Terpercaya dan terbaik\ndengan informasi yang transparan dan aman.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kCream.withOpacity(0.8), fontSize: 12, height: 1.6),
                  ),
                  const SizedBox(height: 18),
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: kCream,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: kGoldBright, width: 1.2),
                        boxShadow: [
                          BoxShadow(color: kGold.withOpacity(0.2), blurRadius: 10),
                        ],
                      ),
                      child: Row(children: [
                        const SizedBox(width: 14),
                        const Icon(Icons.search, color: kGold, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchCtrl,
                            style: const TextStyle(fontSize: 13, color: kDark),
                            decoration: InputDecoration(
                              hintText: 'Cari nama travel umrah/haji',
                              hintStyle: TextStyle(color: kMuted.withOpacity(0.7), fontSize: 13),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            onSubmitted: (val) => fetchData(search: val),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => fetchData(search: _searchCtrl.text),
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(color: kGold, shape: BoxShape.circle),
                            child: const Icon(Icons.search, color: Colors.white, size: 16),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Nearby button
                  GestureDetector(
                    onTap: isNearbyLoading ? null : _cariTerdekat,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                      decoration: BoxDecoration(
                        color: nearbyIds.isNotEmpty
                            ? kGreen.withOpacity(0.85)
                            : kGold.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: nearbyIds.isNotEmpty ? kGreen : kGoldBright,
                          width: 1.5,
                        ),
                        boxShadow: nearbyIds.isNotEmpty
                            ? [BoxShadow(
                            color: kGreen.withOpacity(0.3),
                            blurRadius: 10, offset: const Offset(0, 3))]
                            : [BoxShadow(
                            color: kGold.withOpacity(0.15),
                            blurRadius: 8)],
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        if (isNearbyLoading)
                          const SizedBox(width: 14, height: 14,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2))
                        else
                          Icon(
                              nearbyIds.isNotEmpty ? Icons.location_on : Icons.my_location,
                              color: Colors.white, size: 15),
                        const SizedBox(width: 8),
                        Text(
                          isNearbyLoading
                              ? 'Mendeteksi lokasi...'
                              : nearbyIds.isNotEmpty
                              ? '${nearbyIds.length} Travel Ditemukan'
                              : 'Cari Travel Terdekat',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12,
                              fontWeight: FontWeight.w700, letterSpacing: 0.3),
                        ),
                        if (nearbyIds.isNotEmpty && !isNearbyLoading) ...[
                          const SizedBox(width: 8),
                          GestureDetector(
                              onTap: () => setState(() => nearbyIds = {}),
                              child: const Icon(Icons.close,
                                  color: Colors.white70, size: 14)),
                        ],
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // ── ERROR ─────────────────────────────────────────────────────────────────
  Widget _buildError() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.wifi_off, color: kGold, size: 52),
        const SizedBox(height: 12),
        Text(error, textAlign: TextAlign.center,
            style: const TextStyle(color: kMuted, fontSize: 13)),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: kGold,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          onPressed: fetchData,
          child: const Text('Coba Lagi', style: TextStyle(color: Colors.white)),
        ),
      ]),
    );
  }

  // ── FILTER ────────────────────────────────────────────────────────────────
  Widget _buildFilter() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: filters.map((f) {
            final isActive = f == activeFilter;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: () => setState(() => activeFilter = f),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                  decoration: BoxDecoration(
                    color: isActive ? kGold : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kGoldLight, width: 1.5),
                    boxShadow: isActive
                        ? [BoxShadow(color: kGold.withOpacity(0.3),
                        blurRadius: 8, offset: const Offset(0, 3))]
                        : [],
                  ),
                  child: Text(f,
                      style: TextStyle(
                          color: isActive ? Colors.white : kGold,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── GRID ──────────────────────────────────────────────────────────────────
  Widget _buildGrid() {
    final filtered = travels.where((t) {
      if (activeFilter == 'Umrah') return t.nomorSkUmrah?.isNotEmpty ?? false;
      if (activeFilter == 'Haji') return t.nomorSkHaji?.isNotEmpty ?? false;
      return true;
    }).toList();

    if (filtered.isEmpty) {
      return SliverFillRemaining(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, color: kGold, size: 48),
            const SizedBox(height: 12),
            Text('Tidak ada travel untuk filter "$activeFilter"',
                style: const TextStyle(color: kMuted, fontSize: 13)),
          ],
        )),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          childAspectRatio: 0.68,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) => _buildCard(filtered[index]),
          childCount: filtered.length,
        ),
      ),
    );
  }

  // ── CARD: Arsitektur Masjid ────────────────────────────────────────────────
  Widget _buildCard(Travel t) {
    final isFav    = favorites.contains(t.id);
    final isNearby = nearbyIds.contains(t.id);
    final isResmi  = (t.nomorSkUmrah?.isNotEmpty ?? false) ||
        (t.nomorSkHaji?.isNotEmpty ?? false);

    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => TravelDetailScreen(travelId: t.id))),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Card utama ──
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border.all(
                color: isNearby ? kGreen : kCreamBorder,
                width: isNearby ? 2.0 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: isNearby
                      ? kGreen.withOpacity(0.18)
                      : kGold.withOpacity(0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Area arch logo (bentuk lengkung masjid) ──────────────
                SizedBox(
                  height: 110,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background arch gradient
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                        child: Container(
                          height: 110,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [kCreamDeep, kCream],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),

                      // Arch shape di tengah (ornamen)
                      Positioned(
                        top: 0,
                        child: CustomPaint(
                          size: const Size(double.maxFinite, 110),
                          painter: _ArchOrnamentPainter(
                            color: kGoldShimmer.withOpacity(0.35),
                            nearby: isNearby,
                          ),
                        ),
                      ),

                      // Gold shimmer border atas — ikut lengkungan radius 50
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _CardTopBorderPainter(
                            color: isNearby ? kGreen : kGold,
                            radius: 60,
                            strokeWidth: 2.5,
                          ),
                        ),
                      ),

                      // Logo perusahaan — ditampilkan FULL tanpa crop berlebihan
                      Container(
                        width: 72, height: 72,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isNearby ? kGreen : kGoldBright,
                            width: 2.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: (isNearby ? kGreen : kGold).withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: t.logo != null && t.logo!.isNotEmpty
                              ? Image.network(
                            t.logo!,
                            width: 72, height: 72,
                            // FIT: contain agar logo kotak/persegi panjang
                            // tetap kelihatan full tanpa terpotong
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => _logoFallback(),
                          )
                              : _logoFallback(),
                        ),
                      ),

                      // Badge resmi (pojok kanan atas)
                      if (isResmi)
                        Positioned(
                          top: 10, right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: kGold,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('Resmi',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ),

                      // Badge terdekat
                      if (isNearby)
                        Positioned(
                          top: 10, left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: kGreen,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(color: kGreen.withOpacity(0.4),
                                    blurRadius: 6),
                              ],
                            ),
                            child: const Text('Terdekat',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ),
                    ],
                  ),
                ),

                // ── Garis pemisah gold ──────────────────────────────────
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isNearby
                          ? [Colors.transparent, kGreen, Colors.transparent]
                          : [Colors.transparent, kGold, Colors.transparent],
                    ),
                  ),
                ),

                // ── Info travel ─────────────────────────────────────────
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.nama,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700,
                                color: kDark, height: 1.3)),
                        const SizedBox(height: 6),
                        _infoChip(Icons.location_on, t.alamat ?? '-'),
                        _infoChip(Icons.phone, t.telepon ?? '-'),
                        _infoChip(Icons.email_outlined, t.email ?? '-'),
                      ],
                    ),
                  ),
                ),

                // ── Tombol bawah ────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tombol detail
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [kGold, kGoldLight],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: kGold.withOpacity(0.35),
                                blurRadius: 6, offset: const Offset(0, 2)),
                          ],
                        ),
                        child: const Text('Detail',
                            style: TextStyle(color: Colors.white,
                                fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      // Bookmark
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isFav ? favorites.remove(t.id) : favorites.add(t.id);
                          });
                          await _saveFavorites();
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            isFav ? Icons.bookmark : Icons.bookmark_border,
                            key: ValueKey(isFav),
                            color: kGold, size: 22,
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
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Icon(icon, size: 10, color: kGold),
        const SizedBox(width: 4),
        Expanded(
          child: Text(text,
              style: const TextStyle(fontSize: 10, color: kMuted),
              overflow: TextOverflow.ellipsis, maxLines: 1),
        ),
      ]),
    );
  }

  Widget _logoFallback() => Container(
    color: kCreamDeep,
    child: const Icon(Icons.mosque, size: 32, color: kGold),
  );

  // ── FLOATING BUTTONS ──────────────────────────────────────────────────────
  Widget _buildFloatingButtons() {
    return Positioned(
      bottom: 30, right: 20,
      child: Row(children: [
        GestureDetector(
          onTap: () => showMLModal(context),
          child: Container(
            width: 54, height: 54,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kGold, kGoldLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(color: kGoldShimmer, width: 1),
              boxShadow: [
                BoxShadow(color: kGold.withOpacity(0.4),
                    blurRadius: 16, spreadRadius: 2),
              ],
            ),
            child: const Icon(Icons.auto_fix_high, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => setState(() => chatOpen = !chatOpen),
          child: Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: kGoldBright, width: 1.5),
              boxShadow: [
                BoxShadow(color: kGold.withOpacity(0.15), blurRadius: 12),
              ],
            ),
            child: const Icon(Icons.chat_bubble_outline, color: kGold, size: 22),
          ),
        ),
      ]),
    );
  }

  Widget _buildChatbot() {
    return Positioned(
      bottom: 100, right: 20,
      child: ChatbotBox(onClose: () => setState(() => chatOpen = false)),
    );
  }
}

// ─── PAINTER: Border atas card mengikuti lengkungan radius ───────────────────
class _CardTopBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double strokeWidth;
  _CardTopBorderPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final r = radius.clamp(0.0, size.width / 2);
    final path = Path();

    // Hanya gambar sisi atas: kiri bawah → lengkung kiri → lurus → lengkung kanan → kanan bawah
    path.moveTo(0, size.height);
    path.lineTo(0, r);
    path.arcToPoint(Offset(r, 0), radius: Radius.circular(r), clockwise: true);
    path.lineTo(size.width - r, 0);
    path.arcToPoint(Offset(size.width, r), radius: Radius.circular(r), clockwise: true);
    path.lineTo(size.width, size.height);

    // Clip agar hanya area lengkung atas yang tampil
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, r + strokeWidth * 2));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CardTopBorderPainter old) =>
      old.color != color || old.radius != radius;
}

// ─── PAINTER: Ornamen arch masjid di belakang logo ────────────────────────────
class _ArchOrnamentPainter extends CustomPainter {
  final Color color;
  final bool nearby;
  _ArchOrnamentPainter({required this.color, required this.nearby});

  @override
  void paint(Canvas canvas, Size size) {
    final w = 140.0; // lebar arch
    final h = 100.0; // tinggi arch
    final cx = size.width / 2; // center x (tidak dipakai size.width karena infinite)

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Arch utama (tengah, lebih besar)
    final archPath = Path();
    archPath.moveTo(cx - w / 2, h);
    archPath.lineTo(cx - w / 2, h * 0.38);
    archPath.cubicTo(
      cx - w / 2, h * 0.04,
      cx - w * 0.12, 0,
      cx, 0,
    );
    archPath.cubicTo(
      cx + w * 0.12, 0,
      cx + w / 2, h * 0.04,
      cx + w / 2, h * 0.38,
    );
    archPath.lineTo(cx + w / 2, h);
    archPath.close();
    canvas.drawPath(archPath, paint);

    // Dua arch kecil di sisi (dekorasi)
    final smallW = 48.0;
    final smallH = 72.0;
    for (final dx in [cx - w / 2 - smallW * 0.6, cx + w / 2 - smallW * 0.4]) {
      final sPath = Path();
      sPath.moveTo(dx, h);
      sPath.lineTo(dx, smallH * 0.4);
      sPath.cubicTo(
        dx, smallH * 0.05,
        dx + smallW * 0.12, 0,
        dx + smallW / 2, 0,
      );
      sPath.cubicTo(
        dx + smallW * 0.88, 0,
        dx + smallW, smallH * 0.05,
        dx + smallW, smallH * 0.4,
      );
      sPath.lineTo(dx + smallW, h);
      sPath.close();
      canvas.drawPath(sPath, paint..color = color.withOpacity(0.5));
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── BOTTOM SHEET NEARBY ──────────────────────────────────────────────────────
class _NearbyBottomSheet extends StatelessWidget {
  final List<NearbyTravel> results;
  final void Function(int) onSelectTravel;
  const _NearbyBottomSheet({required this.results, required this.onSelectTravel});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.65),
      decoration: const BoxDecoration(
        color: kCream,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          margin: const EdgeInsets.only(top: 12),
          width: 40, height: 4,
          decoration: BoxDecoration(
              color: kCreamBorder, borderRadius: BorderRadius.circular(2)),
        ),
        // Gold bar
        const SizedBox(height: 10),
        Container(height: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [kGold, kGoldBright, kGoldShimmer, kGoldBright, kGold]),
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: kGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.location_on, color: kGreen, size: 18),
            ),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Travel Terdekat dari Anda',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: kDark)),
              Text(
                results.isEmpty
                    ? 'Tidak ada dalam radius 50 km'
                    : '${results.length} travel ditemukan (radius 50 km)',
                style: const TextStyle(fontSize: 11, color: kMuted),
              ),
            ]),
          ]),
        ),
        Divider(color: kCreamBorder, height: 1),
        if (results.isEmpty)
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(children: [
              Icon(Icons.location_off, color: kCreamBorder, size: 52),
              const SizedBox(height: 12),
              const Text('Tidak ada travel dalam radius 50 km\ndari lokasi Anda saat ini.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kMuted, fontSize: 13)),
            ]),
          )
        else
          Flexible(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: results.length,
              separatorBuilder: (_, __) => Divider(height: 1, color: kCreamBorder,
                  indent: 76, endIndent: 20),
              itemBuilder: (_, i) {
                final t = results[i];
                return InkWell(
                  onTap: () { Navigator.pop(context); onSelectTravel(t.id); },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(children: [
                      // Logo nearby
                      Container(
                        width: 48, height: 48,
                        decoration: BoxDecoration(
                          color: kCreamDeep,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kGoldBright, width: 1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: t.logo != null && t.logo!.isNotEmpty
                              ? Image.network(t.logo!, fit: BoxFit.contain,
                              headers: const {'User-Agent': 'Mozilla/5.0'},
                              errorBuilder: (_, __, ___) =>
                              const Icon(Icons.mosque, color: kGold, size: 22))
                              : const Icon(Icons.mosque, color: kGold, size: 22),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(t.nama,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700, color: kDark),
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          if (t.alamat != null && t.alamat!.isNotEmpty)
                            Text(t.alamat!,
                                style: const TextStyle(fontSize: 11, color: kMuted),
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: kCreamDeep,
                          border: Border.all(color: kGoldBright, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('${t.distanceKm.toStringAsFixed(1)} km',
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w700, color: kGold)),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: 16),
      ]),
    );
  }
}