import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ── COLORS ──
const Color kGold = Color(0xFFF5B400);
const Color kGoldLight = Color(0xFFFFF8E1);
const Color kDark = Color(0xFF1A1200);
const Color kGoldDark = Color(0xFFD4A017);

// ── MODEL ──
class Travel {
  final int id;
  final String nama;
  final String? alamat;
  final String? telepon;
  final String? email;
  final String? logo;
  final String? nomorSkUmrah;
  final String? nomorSkHaji;

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

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
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
}

// ── SERVICE ──
class TravelService {
  static const String baseUrl = "http://192.168.18.20:8000";

  static Future<List<Travel>> getTravels({String? search}) async {
    final uri = Uri.parse("$baseUrl/api/travel")
        .replace(queryParameters: search != null && search.isNotEmpty ? {'search': search} : null);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Travel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal load data");
    }
  }
}

// ── MAIN SCREEN ──
class TravelScreen extends StatefulWidget {
  const TravelScreen({super.key});

  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  List<Travel> travels = [];
  bool isLoading = true;
  String error = '';
  String activeFilter = 'Semua Paket';
  bool chatOpen = false;
  bool showModal = false;
  Set<int> favorites = {};
  final TextEditingController _searchCtrl = TextEditingController();
  final List<String> filters = ['Semua Paket', 'Umrah', 'Haji'];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData({String? search}) async {
    setState(() => isLoading = true);
    try {
      final data = await TravelService.getTravels(search: search);
      setState(() {
        travels = data;
        isLoading = false;
        error = '';
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content
          CustomScrollView(
            slivers: [
              _buildHero(),
              _buildFilter(),
              isLoading
                  ? const SliverFillRemaining(child: Center(child: CircularProgressIndicator(color: kGold)))
                  : error.isNotEmpty
                      ? SliverFillRemaining(child: Center(child: Text(error)))
                      : _buildGrid(),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // Floating buttons (bottom right)
          Positioned(
            bottom: 35,
            right: 20,
            child: Row(
              children: [
                // AI Forecast button
                GestureDetector(
                  onTap: () => setState(() => showModal = true),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: kGold,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: kGold.withOpacity(0.4), blurRadius: 20, spreadRadius: 2)],
                    ),
                    child: const Icon(Icons.auto_fix_high, color: Colors.white, size: 26),
                  ),
                ),
                const SizedBox(width: 12),
                // Chat button
                GestureDetector(
                  onTap: () => setState(() => chatOpen = !chatOpen),
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: kGold, width: 2),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15)],
                    ),
                    child: const Icon(Icons.chat_bubble_outline, color: kGold, size: 24),
                  ),
                ),
              ],
            ),
          ),

          // Chatbot overlay
          if (chatOpen) _buildChatbot(),

          // AI Modal overlay
          if (showModal) _buildAIModal(),
        ],
      ),
    );
  }

  // ── HERO ──
  Widget _buildHero() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            height: 320,
            margin: const EdgeInsets.only(top: 0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/travel_back.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'TRAVEL',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Temukan Travel Umrah Terpercaya dan terbaik\ndengan informasi yang transparan dan aman.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          const Icon(Icons.search, color: Color(0xFF999999), size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchCtrl,
                              style: const TextStyle(fontSize: 13, color: Colors.black87),
                              decoration: const InputDecoration(
                                hintText: 'Cari nama travel umrah/haji',
                                hintStyle: TextStyle(color: Color(0xFF999999), fontSize: 13),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onSubmitted: (val) => fetchData(search: val),
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
        ],
      ),
    );
  }

  // ── FILTER BUTTONS ──
  Widget _buildFilter() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: filters.map((f) {
            final isActive = f == activeFilter;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onTap: () => setState(() => activeFilter = f),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive ? kGold : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kGold, width: 1.5),
                  ),
                  child: Text(
                    f,
                    style: TextStyle(
                      color: isActive ? Colors.white : kGold,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── TRAVEL GRID ──
  Widget _buildGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 14,
          childAspectRatio: 0.62,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildCard(travels[index]),
          childCount: travels.length,
        ),
      ),
    );
  }

  Widget _buildCard(Travel t) {
    final isFav = favorites.contains(t.id);
    final isResmi = (t.nomorSkUmrah != null && t.nomorSkUmrah!.isNotEmpty) ||
        (t.nomorSkHaji != null && t.nomorSkHaji!.isNotEmpty);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(80),
          topRight: Radius.circular(80),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        border: Border.all(color: kGold, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          // Card image (rounded top)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(78),
              topRight: Radius.circular(78),
            ),
            child: t.logo != null && t.logo!.isNotEmpty
                ? Image.network(
                    t.logo!,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholderImg(),
                  )
                : _placeholderImg(),
          ),

          // Card body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    t.nama,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: 0.3,
                    ),
                  ),
                  const Divider(color: kGold, thickness: 1.5, height: 12),
                  _infoRow(Icons.location_on, t.alamat ?? 'Indramayu'),
                  _infoRow(Icons.phone, t.telepon ?? '08xxx'),
                  _infoRow(Icons.email_outlined, t.email ?? '-'),
                  _infoRow(
                    Icons.verified,
                    isResmi ? 'Resmi & Terdaftar' : 'Aktif',
                  ),
                ],
              ),
            ),
          ),

          // Card footer
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Detail button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: kGold,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Detail',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                // Favorite button
                GestureDetector(
                  onTap: () => setState(() {
                    if (isFav) favorites.remove(t.id);
                    else favorites.add(t.id);
                  }),
                  child: Icon(
                    isFav ? Icons.bookmark : Icons.bookmark_border,
                    color: kGold,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 11, color: kGold),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 10, color: Color(0xFF444444)),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholderImg() {
    return Container(
      height: 100,
      width: double.infinity,
      color: kGoldLight,
      child: const Icon(Icons.mosque, size: 40, color: kGold),
    );
  }

  // ── CHATBOT ──
  Widget _buildChatbot() {
    return Positioned(
      bottom: 110,
      right: 20,
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 320,
          height: 480,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF4),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: kGoldDark.withOpacity(0.35)),
          ),
          child: Column(
            children: [
              // Chat header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A1200), Color(0xFF2D1F00), Color(0xFF3D2E00)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD4A017), Color(0xFFF5C842)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: kGold.withOpacity(0.4), blurRadius: 10)],
                          ),
                          child: const Icon(Icons.smart_toy, color: Color(0xFF1A1200), size: 20),
                        ),
                        Positioned(
                          bottom: 1, right: 1,
                          child: Container(
                            width: 10, height: 10,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4ADE80),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF1A1200), width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Asisten RAVOLA',
                              style: TextStyle(
                                color: Color(0xFFF5C842),
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              )),
                          Text('Online',
                              style: TextStyle(
                                color: Color(0xFF4ADE80),
                                fontSize: 10,
                                letterSpacing: 0.8,
                              )),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => chatOpen = false),
                      child: Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.07),
                          shape: BoxShape.circle,
                          border: Border.all(color: kGoldDark.withOpacity(0.3)),
                        ),
                        child: const Icon(Icons.close, size: 14, color: Color(0xFFD4A017)),
                      ),
                    ),
                  ],
                ),
              ),
              // Chat body
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFFDF4), Color(0xFFFFF9E6)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _chatBubble("Assalamu'alaikum Warahmatullahi Wabarakatuh."),
                        const SizedBox(height: 8),
                        _chatBubble("Aku Asisten Pribadi RAVOLA.\nSilakan pilih informasi di bawah ini:"),
                        const SizedBox(height: 10),
                        _chatMenuBtn("1. Informasi Paket Umrah"),
                        _chatMenuBtn("2. Informasi Paket Haji"),
                        _chatMenuBtn("3. Syarat & Ketentuan"),
                        _chatMenuBtn("4. Hubungi Kami"),
                      ],
                    ),
                  ),
                ),
              ),
              // Chat input
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: kGoldDark.withOpacity(0.18))),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF9E6),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: kGoldDark.withOpacity(0.3)),
                        ),
                        child: const TextField(
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            hintText: 'Ketik pesan...',
                            hintStyle: TextStyle(color: Color(0x663D2E00), fontSize: 12),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD4A017), Color(0xFFF5C842)],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: kGold.withOpacity(0.4), blurRadius: 10)],
                      ),
                      child: const Icon(Icons.send, color: Color(0xFF1A1200), size: 15),
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

  Widget _chatBubble(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
        border: Border.all(color: kGoldDark.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: kGold.withOpacity(0.08), blurRadius: 8)],
      ),
      child: Text(text, style: const TextStyle(fontSize: 12.5, height: 1.5, color: Color(0xFF1A1200))),
    );
  }

  Widget _chatMenuBtn(String label) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            left: const BorderSide(color: kGoldDark, width: 3),
            top: BorderSide(color: kGoldDark.withOpacity(0.25)),
            right: BorderSide(color: kGoldDark.withOpacity(0.25)),
            bottom: BorderSide(color: kGoldDark.withOpacity(0.25)),
          ),
          boxShadow: [BoxShadow(color: kGoldDark.withOpacity(0.07), blurRadius: 5)],
        ),
        child: Text(label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF3D2E00),
            )),
      ),
    );
  }

  // ── AI PREDICTION MODAL ──
  Widget _buildAIModal() {
    return GestureDetector(
      onTap: () => setState(() => showModal = false),
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Left panel (form) — shown on top in mobile
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calculate, color: kGold),
                            const SizedBox(width: 8),
                            const Text('Perencanaan Finansial',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => setState(() => showModal = false),
                              child: const Icon(Icons.close, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _modalInput('Budget Saat Ini', 'Contoh: 20.000.000'),
                        const SizedBox(height: 12),
                        _modalInput('Nabung Per Bulan', 'Contoh: 2.000.000'),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kGold,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {},
                            child: const Text('Mulai Analisis',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: kGold.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.storage, size: 14, color: kGold),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Analisis berdasarkan data historis harga Haji 8 tahun terakhir.',
                                style: TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Right panel (result)
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Text(
                          'Masukkan data finansial Anda\nuntuk melihat estimasi keberangkatan.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: kGold, width: 3),
                          ),
                          child: const Center(
                            child: Icon(Icons.mosque, color: kGold, size: 24),
                          ),
                        ),
                      ],
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

  Widget _modalInput(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(),
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text('Rp', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}