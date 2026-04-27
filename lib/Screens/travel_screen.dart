import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'travel-detail_screen.dart';
import 'ai_modal_widget.dart';
import 'chatbot.dart';

const Color kGold = Color(0xFFF5B400);
const Color kGoldLight = Color(0xFFFFF8E1);
const Color kDark = Color(0xFF1A1200);
const Color kGoldDark = Color(0xFFD4A017);

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

class TravelService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<List<Travel>> getTravels({String? search}) async {
    final uri = Uri.parse("$baseUrl/api/travel").replace(
      queryParameters: search != null && search.isNotEmpty
          ? {'search': search}
          : null,
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Travel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal load data");
    }
  }
}

class TravelScreen extends StatefulWidget {
  const TravelScreen({super.key});
  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  List<Travel> travels = [];
  bool isLoading = true, chatOpen = false;
  String error = '', activeFilter = 'Semua Paket';
  Set<int> favorites = {};
  final _searchCtrl = TextEditingController();
  final filters = ['Semua Paket', 'Umrah', 'Haji'];

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
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildHero(),
              _buildFilter(),
              if (isLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator(color: kGold)),
                )
              else if (error.isNotEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wifi_off, color: kGold, size: 52),
                        const SizedBox(height: 12),
                        Text(
                          error,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kGold,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: fetchData,
                          child: const Text(
                            'Coba Lagi',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                _buildGrid(),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // Floating buttons
          Positioned(
            bottom: 30,
            right: 20,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => showMLModal(context),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: kGold,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: kGold.withOpacity(0.4),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_fix_high,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => setState(() => chatOpen = !chatOpen),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: kGold, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: kGold,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (chatOpen) _buildChatbot(),
        ],
      ),
    );
  }

  // ── HERO ──────────────────────────────────────────────────────────────────
  Widget _buildHero() {
    return SliverToBoxAdapter(
      child: Container(
        height: 300,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/travel_back.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(36),
            bottomRight: Radius.circular(36),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white38),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'TRAVEL',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Temukan Travel Umrah Terpercaya dan terbaik\ndengan informasi yang transparan dan aman.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.5,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 14),
                        const Icon(
                          Icons.search,
                          color: Color(0xFFAAAAAA),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchCtrl,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Cari nama travel umrah/haji',
                              hintStyle: TextStyle(
                                color: Color(0xFFAAAAAA),
                                fontSize: 13,
                              ),
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
                            decoration: const BoxDecoration(
                              color: kGold,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 16,
                            ),
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
      ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? kGold : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kGold, width: 1.5),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: kGold.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
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

  // ── GRID ──────────────────────────────────────────────────────────────────
  Widget _buildGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildCard(travels[index]),
          childCount: travels.length,
        ),
      ),
    );
  }

  // ── CARD ──────────────────────────────────────────────────────────────────
  Widget _buildCard(Travel t) {
    final isFav = favorites.contains(t.id);
    final isResmi =
        (t.nomorSkUmrah?.isNotEmpty ?? false) ||
        (t.nomorSkHaji?.isNotEmpty ?? false);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kGold.withOpacity(0.6), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: kGold.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
            child: t.logo != null && t.logo!.isNotEmpty
                ? Image.network(
                    t.logo!,
                    height: 85,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholderImg(),
                  )
                : _placeholderImg(),
          ),
          // Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.nama,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                      height: 1.3,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Divider(color: kGold, thickness: 1, height: 1),
                  ),
                  _infoRow(Icons.location_on, t.alamat ?? '-'),
                  _infoRow(Icons.phone, t.telepon ?? '-'),
                  _infoRow(Icons.email_outlined, t.email ?? '-'),
                  _infoRow(
                    Icons.verified_outlined,
                    isResmi ? 'Resmi & Terdaftar' : 'Aktif',
                  ),
                ],
              ),
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TravelDetailScreen(travelId: t.id),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: kGold,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: kGold.withOpacity(0.35),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Detail',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    isFav ? favorites.remove(t.id) : favorites.add(t.id);
                  }),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      isFav ? Icons.bookmark : Icons.bookmark_border,
                      key: ValueKey(isFav),
                      color: kGold,
                      size: 22,
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
              style: const TextStyle(fontSize: 10, color: Color(0xFF555555)),
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
      height: 85,
      width: double.infinity,
      color: kGoldLight,
      child: const Icon(Icons.mosque, size: 36, color: kGold),
    );
  }

  // ── CHATBOT ───────────────────────────────────────────────────────────────
  Widget _buildChatbot() {
    return Positioned(
      bottom: 100,
      right: 20,
      child: ChatbotBox(onClose: () => setState(() => chatOpen = false)),
    );
  }
}
