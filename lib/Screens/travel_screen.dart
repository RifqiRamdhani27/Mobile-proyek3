import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

// ─── MODEL ───────────────────────────────────────────────────────────────────
class Travel {
  final int id;
  final String namaTrevel;
  final String? alamat;
  final String? nomorTelepon;
  final String? email;
  final String? nomorSkUmrah;
  final String? nomorSkHaji;
  final String? logo;

  Travel({
    required this.id,
    required this.namaTrevel,
    this.alamat,
    this.nomorTelepon,
    this.email,
    this.nomorSkUmrah,
    this.nomorSkHaji,
    this.logo,
  });

  factory Travel.fromJson(Map<String, dynamic> json) => Travel(
        id: json['id'],
        namaTrevel: json['nama_travel'] ?? '',
        alamat: json['alamat'],
        nomorTelepon: json['nomor_telepon'],
        email: json['email'],
        nomorSkUmrah: json['nomor_sk_umrah'],
        nomorSkHaji: json['nomor_sk_haji'],
        logo: json['logo'],
      );

  String get statusLabel =>
      (nomorSkUmrah != null || nomorSkHaji != null) ? 'Resmi & Terdaftar' : 'Aktif';
}

// ─── CONSTANTS ───────────────────────────────────────────────────────────────
const String kBaseUrl = 'http://localhost:8000/api/travel';
const String kApiUrl = '$kBaseUrl/api';

const Color kGold = Color(0xFFF5B400);
const Color kGoldDark = Color(0xFFD4A017);
const Color kGoldLight = Color(0xFFFFF8E1);
const Color kDarkBg = Color(0xFF1A1200);
const Color kCardBg = Color(0xFFFFFFFF);

// ─── MAIN SCREEN ─────────────────────────────────────────────────────────────
class TravelScreen extends StatefulWidget {
  const TravelScreen({super.key});

  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen>
    with TickerProviderStateMixin {
  // State
  List<Travel> _travels = [];
  List<Travel> _filtered = [];
  bool _isLoading = true;
  String _error = '';
  String _activeFilter = 'Semua Paket';
  final TextEditingController _searchCtrl = TextEditingController();
  final Set<int> _favorites = {};

  // Chatbot
  bool _chatOpen = false;
  List<Map<String, dynamic>> _chatMessages = [];
  List<Map<String, dynamic>> _chatMenu = [];

  // AI Modal
  bool _modalOpen = false;
  final TextEditingController _budgetCtrl = TextEditingController();
  final TextEditingController _savingCtrl = TextEditingController();
  bool _aiLoading = false;
  Map<String, dynamic>? _aiResult;

  late AnimationController _chatAnimCtrl;
  late Animation<double> _chatAnim;

  @override
  void initState() {
    super.initState();
    _chatAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _chatAnim = CurvedAnimation(parent: _chatAnimCtrl, curve: Curves.easeOutCubic);
    _fetchTravels();
  }

  @override
  void dispose() {
    _chatAnimCtrl.dispose();
    _searchCtrl.dispose();
    _budgetCtrl.dispose();
    _savingCtrl.dispose();
    super.dispose();
  }

  // ── API CALLS ──────────────────────────────────────────────────────────────
  Future<void> _fetchTravels({String search = ''}) async {
    setState(() => _isLoading = true);
    try {
      final uri = Uri.parse('$kApiUrl/travels').replace(
        queryParameters: search.isNotEmpty ? {'search': search} : null,
      );
      final res = await http.get(uri, headers: {'Accept': 'application/json'});
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        setState(() {
          _travels = data.map((e) => Travel.fromJson(e)).toList();
          _applyFilter();
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Gagal memuat data (${res.statusCode})';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Tidak dapat terhubung ke server';
        _isLoading = false;
      });
    }
  }

  void _applyFilter() {
    setState(() {
      if (_activeFilter == 'Umrah') {
        _filtered = _travels
            .where((t) => t.nomorSkUmrah != null && t.nomorSkUmrah!.isNotEmpty)
            .toList();
      } else if (_activeFilter == 'Haji') {
        _filtered = _travels
            .where((t) => t.nomorSkHaji != null && t.nomorSkHaji!.isNotEmpty)
            .toList();
      } else {
        _filtered = List.from(_travels);
      }
    });
  }

  Future<void> _fetchChatMenu() async {
    try {
      final res = await http.get(Uri.parse('$kApiUrl/chatbot/menu'),
          headers: {'Accept': 'application/json'});
      if (res.statusCode == 200) {
        setState(() => _chatMenu = List<Map<String, dynamic>>.from(jsonDecode(res.body)));
      }
    } catch (_) {}
  }

  Future<void> _sendChatMenu(int number) async {
    try {
      final res = await http.post(
        Uri.parse('$kApiUrl/chatbot'),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode({'menu_number': number}),
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          _chatMessages.add({'type': 'bot', 'text': '**${data['title']}**\n\n${data['response'] ?? 'Informasi belum tersedia.'}'});
          _chatMessages.add({'type': 'followup'});
        });
      }
    } catch (_) {}
  }

  Future<void> _processAiPrediction() async {
    final budget = _budgetCtrl.text.replaceAll('.', '');
    final saving = _savingCtrl.text.replaceAll('.', '');
    if (budget.isEmpty || saving.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan masukkan budget dan tabungan bulanan')),
      );
      return;
    }
    setState(() { _aiLoading = true; _aiResult = null; });
    try {
      final res = await http.post(
        Uri.parse('$kApiUrl/haji/predict'),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode({'budget': budget, 'saving': saving}),
      );
      if (res.statusCode == 200) {
        setState(() { _aiResult = jsonDecode(res.body); _aiLoading = false; });
      }
    } catch (_) {
      setState(() => _aiLoading = false);
    }
  }

  // ── HELPERS ───────────────────────────────────────────────────────────────
  String _formatRupiah(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    final buf = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buf.write('.');
      buf.write(digits[i]);
    }
    return buf.toString();
  }

  String _logoUrl(String? logo) {
    if (logo == null || logo.isEmpty) return '';
    return '$kBaseUrl/storage/$logo';
  }

  void _toggleChat() {
    setState(() => _chatOpen = !_chatOpen);
    if (_chatOpen) {
      _chatAnimCtrl.forward();
      if (_chatMessages.isEmpty) {
        _chatMessages = [
          {'type': 'bot', 'text': "Assalamu'alaikum Warahmatullahi Wabarakatuh."},
          {'type': 'bot', 'text': 'Aku Asisten Pribadi RAVOLA.\nSilakan pilih informasi di bawah ini:'},
          {'type': 'menu'},
        ];
        _fetchChatMenu();
      }
    } else {
      _chatAnimCtrl.reverse();
    }
  }

  // ── BUILD ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildHero(),
              _buildFilter(),
              _buildTravelList(),
            ],
          ),
          // Chatbot overlay
          if (_chatOpen) _buildChatbot(),
          // AI Modal
          if (_modalOpen) _buildAiModal(),
          // FABs
          _buildFloatingButtons(),
        ],
      ),
    );
  }

  // ── HERO ──────────────────────────────────────────────────────────────────
  Widget _buildHero() {
    return SliverToBoxAdapter(
      child: Container(
        height: 280,
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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'TRAVEL',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Temukan Travel Umrah Terpercaya dengan\ninformasi yang transparan, aman, dan terpercaya.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  _buildSearchBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF999999), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchCtrl,
              style: const TextStyle(fontSize: 13, color: Color(0xFF333333)),
              decoration: const InputDecoration(
                hintText: 'Cari nama travel umrah/haji',
                hintStyle: TextStyle(color: Color(0xFF999999), fontSize: 13),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
              onSubmitted: (val) => _fetchTravels(search: val),
            ),
          ),
        ],
      ),
    );
  }

  // ── FILTER ────────────────────────────────────────────────────────────────
  Widget _buildFilter() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ['Semua Paket', 'Umrah', 'Haji'].map((label) {
            final active = _activeFilter == label;
            return GestureDetector(
              onTap: () {
                setState(() => _activeFilter = label);
                _applyFilter();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: active ? kGold : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kGold),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: active ? Colors.white : kGold,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── TRAVEL LIST ───────────────────────────────────────────────────────────
  Widget _buildTravelList() {
    if (_isLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator(color: kGold)),
      );
    }
    if (_error.isNotEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
              const SizedBox(height: 12),
              Text(_error, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _fetchTravels(),
                style: ElevatedButton.styleFrom(backgroundColor: kGold),
                child: const Text('Coba Lagi', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }
    if (_filtered.isEmpty) {
      return const SliverFillRemaining(
        child: Center(child: Text('Tidak ada travel ditemukan', style: TextStyle(color: Colors.grey))),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 14,
          childAspectRatio: 0.62,
        ),
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => _TravelCard(
            travel: _filtered[i],
            isFavorite: _favorites.contains(_filtered[i].id),
            logoUrl: _logoUrl(_filtered[i].logo),
            onFavorite: () => setState(() {
              if (_favorites.contains(_filtered[i].id)) {
                _favorites.remove(_filtered[i].id);
              } else {
                _favorites.add(_filtered[i].id);
              }
            }),
            onDetail: () {
              // TODO: navigate to detail page
              // Navigator.push(context, MaterialPageRoute(builder: (_) => TravelDetailScreen(id: _filtered[i].id)));
            },
          ),
          childCount: _filtered.length,
        ),
      ),
    );
  }

  // ── FLOATING BUTTONS ──────────────────────────────────────────────────────
  Widget _buildFloatingButtons() {
    return Positioned(
      bottom: 30,
      right: 20,
      child: Row(
        children: [
          // Chat button
          GestureDetector(
            onTap: _toggleChat,
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: kGold, width: 2),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15, offset: const Offset(0, 6))],
              ),
              child: const Icon(Icons.chat_bubble_outline, color: kGold, size: 26),
            ),
          ),
          const SizedBox(width: 12),
          // AI button
          GestureDetector(
            onTap: () => setState(() => _modalOpen = true),
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: kGold,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: kGold.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))],
              ),
              child: const Icon(Icons.auto_fix_high, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  // ── CHATBOT ───────────────────────────────────────────────────────────────
  Widget _buildChatbot() {
    return Positioned(
      bottom: 120,
      right: 16,
      child: FadeTransition(
        opacity: _chatAnim,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(_chatAnim),
          child: Container(
            width: 300,
            height: 420,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF4),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: kGoldDark.withOpacity(0.35)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.22), blurRadius: 30, offset: const Offset(0, 10)),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1A1200), Color(0xFF2D1F00), Color(0xFF3D2E00)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38, height: 38,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [kGoldDark, Color(0xFFF5C842)]),
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: kGold.withOpacity(0.4), blurRadius: 8)],
                        ),
                        child: const Icon(Icons.smart_toy, color: Color(0xFF1A1200), size: 18),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Asisten RAVOLA', style: TextStyle(color: Color(0xFFF5C842), fontWeight: FontWeight.w700, fontSize: 13)),
                            Text('Online', style: TextStyle(color: Color(0xFF4ADE80), fontSize: 10, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: _toggleChat,
                        child: const Icon(Icons.close, color: Colors.white54, size: 20),
                      ),
                    ],
                  ),
                ),
                // Messages
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _chatMessages.length,
                    itemBuilder: (ctx, i) {
                      final msg = _chatMessages[i];
                      if (msg['type'] == 'menu' || msg['type'] == 'followup') {
                        return _buildChatMenuWidget(isFollowUp: msg['type'] == 'followup', index: i);
                      }
                      return _buildChatMessage(msg['text'] ?? '');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatMessage(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        constraints: const BoxConstraints(maxWidth: 220),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16), bottomLeft: Radius.circular(4),
          ),
          border: Border.all(color: kGoldDark.withOpacity(0.2)),
          boxShadow: [BoxShadow(color: kGold.withOpacity(0.06), blurRadius: 6)],
        ),
        child: Text(text, style: const TextStyle(fontSize: 11.5, color: Color(0xFF1A1200), height: 1.5)),
      ),
    );
  }

  Widget _buildChatMenuWidget({required bool isFollowUp, required int index}) {
    if (_chatMenu.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(color: kGold, strokeWidth: 2),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isFollowUp)
          _buildChatMessage('Ada lagi yang ingin Anda tanyakan? 😊'),
        ..._chatMenu.map((menu) => GestureDetector(
          onTap: () async {
            await _sendChatMenu(menu['menu_number']);
          },
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
            ),
            child: Text(
              '${menu['menu_number']}. ${menu['title']}',
              style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500, color: Color(0xFF3D2E00)),
            ),
          ),
        )),
      ],
    );
  }

  // ── AI MODAL ──────────────────────────────────────────────────────────────
  Widget _buildAiModal() {
    return GestureDetector(
      onTap: () => setState(() { _modalOpen = false; _aiResult = null; }),
      child: Container(
        color: Colors.black.withOpacity(0.75),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // prevent dismiss
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 40)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Left panel (input)
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calculate, color: kGold),
                            const SizedBox(width: 8),
                            const Text('Perencanaan Finansial', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => setState(() { _modalOpen = false; _aiResult = null; }),
                              child: const Icon(Icons.close, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildRupiahInput('Budget Saat Ini', _budgetCtrl, 'Contoh: 20.000.000'),
                        const SizedBox(height: 12),
                        _buildRupiahInput('Nabung Per Bulan', _savingCtrl, 'Contoh: 2.000.000'),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _aiLoading ? null : _processAiPrediction,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kGold,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              elevation: 4,
                            ),
                            child: Text(
                              _aiLoading ? 'Menganalisis...' : 'Mulai Analisis',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right panel (result)
                  if (_aiLoading || _aiResult != null)
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: _aiLoading
                          ? const Column(children: [
                              CircularProgressIndicator(color: kGold),
                              SizedBox(height: 12),
                              Text('Menunggu Input Data...', style: TextStyle(color: Colors.grey)),
                            ])
                          : Column(
                              children: [
                                const Text('Estimasi Keberangkatan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
                                  decoration: BoxDecoration(
                                    color: kDarkBg,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Text(
                                    '${_aiResult!['haji_year']}',
                                    style: const TextStyle(fontSize: 52, fontWeight: FontWeight.w900, color: kGold),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: kGoldLight,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: kGold.withOpacity(0.3)),
                                  ),
                                  child: Text(
                                    'MasyaAllah! Berdasarkan data 8 tahun terakhir, harga Haji/Umrah naik rata-rata 5%–7% per tahun. '
                                    'Dengan niat yang lurus dan tabungan yang istiqomah, insyaAllah bisa menginjakkan kaki di Tanah Suci pada tahun ${_aiResult!['haji_year']}. '
                                    'Semoga Allah mudahkan jalannya. 🕌',
                                    style: const TextStyle(fontSize: 12, color: Color(0xFF444444), height: 1.5),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => setState(() { _modalOpen = false; _aiResult = null; }),
                                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                                      child: const Text('Tutup'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kGold,
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                      ),
                                      child: const Text('Simpan Jadwal', style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ]),
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

  Widget _buildRupiahInput(String label, TextEditingController ctrl, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text('Rp', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
              ),
              Expanded(
                child: TextField(
                  controller: ctrl,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onChanged: (val) {
                    final formatted = _formatRupiah(val);
                    if (formatted != val) {
                      ctrl.value = TextEditingValue(
                        text: formatted,
                        selection: TextSelection.collapsed(offset: formatted.length),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── TRAVEL CARD WIDGET ───────────────────────────────────────────────────────
class _TravelCard extends StatefulWidget {
  final Travel travel;
  final bool isFavorite;
  final String logoUrl;
  final VoidCallback onFavorite;
  final VoidCallback onDetail;

  const _TravelCard({
    required this.travel,
    required this.isFavorite,
    required this.logoUrl,
    required this.onFavorite,
    required this.onDetail,
  });

  @override
  State<_TravelCard> createState() => _TravelCardState();
}

class _TravelCardState extends State<_TravelCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _elevation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _elevation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _elevation,
      builder: (ctx, _) => Transform.translate(
        offset: Offset(0, -6 * _elevation.value),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(80),
              topRight: Radius.circular(80),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            border: Border.all(color: const Color(0xFFF5B800), width: 2),
            boxShadow: [
              BoxShadow(
                color: kGold.withOpacity(0.1 + 0.3 * _elevation.value),
                blurRadius: 8 + 10 * _elevation.value,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(78),
                  topRight: Radius.circular(78),
                ),
                child: widget.logoUrl.isNotEmpty
                    ? Image.network(
                        widget.logoUrl,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholderImg(),
                      )
                    : _placeholderImg(),
              ),
              // Body
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.travel.namaTrevel,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A1A),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Divider(color: kGold.withOpacity(0.5), height: 14),
                      _infoRow(Icons.location_on, widget.travel.alamat ?? 'Indramayu'),
                      _infoRow(Icons.phone, widget.travel.nomorTelepon ?? '08xxx'),
                      _infoRow(Icons.email, widget.travel.email ?? '-'),
                      _infoRow(Icons.verified, widget.travel.statusLabel),
                    ],
                  ),
                ),
              ),
              // Footer
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: widget.onDetail,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: kGold,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('Detail', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onFavorite,
                      child: Icon(
                        widget.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                        color: kGold,
                        size: 22,
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

  Widget _infoRow(IconData icon, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 11, color: kGold),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10, color: Color(0xFF444444)),
          ),
        ),
      ],
    ),
  );

  Widget _placeholderImg() => Container(
    height: 100,
    color: kGoldLight,
    child: const Center(child: Icon(Icons.mosque, color: kGold, size: 40)),
  );
}