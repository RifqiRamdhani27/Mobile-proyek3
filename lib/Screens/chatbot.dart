import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

const Color kGold = Color(0xFFF5B400);
const Color kGoldDark = Color(0xFFD4A017);

const String _baseUrl = 'http://127.0.0.1:8000';

class ChatMenu {
  final int menuNumber;
  final String title;
  ChatMenu({required this.menuNumber, required this.title});
  factory ChatMenu.fromJson(Map<String, dynamic> j) =>
      ChatMenu(menuNumber: j['menu_number'], title: j['title']);
}

class ChatbotService {
  static Future<List<ChatMenu>> getMenu() async {
    final res = await http.get(Uri.parse('$_baseUrl/api/chatbot/menu'));
    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);
      return data.map((e) => ChatMenu.fromJson(e)).toList();
    }
    throw Exception('Gagal load menu');
  }

  static Future<Map<String, dynamic>> getResponse(int menuNumber) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/api/chatbot'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'menu_number': menuNumber}),
    );
    if (res.statusCode == 200) return jsonDecode(res.body);
    throw Exception('Gagal ambil respons');
  }
}

class ChatbotBox extends StatefulWidget {
  final VoidCallback onClose;
  const ChatbotBox({super.key, required this.onClose});

  @override
  State<ChatbotBox> createState() => _ChatbotBoxState();
}

class _ChatbotBoxState extends State<ChatbotBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _slide, _fade;
  final _scrollCtrl = ScrollController();
  final List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _slide = Tween(begin: 20.0, end: 0.0)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic));
    _fade = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward();
    _initChat();
  }

  void _initChat() {
    _items.addAll([
      {'type': 'bot', 'text': "Assalamu'alaikum Warahmatullahi Wabarakatuh."},
      {
        'type': 'bot',
        'text': "Aku Asisten Pribadi RAVOLA.\nSilakan pilih informasi di bawah ini:"
      },
    ]);
    _loadMenu(isFollowUp: false);
  }

  Future<void> _loadMenu({required bool isFollowUp}) async {
    try {
      final menus = await ChatbotService.getMenu();
      setState(() {
        if (isFollowUp) {
          _items.add({'type': 'bot', 'text': 'Ada lagi yang ingin Anda tanyakan?'});
        }
        _items.add({
          'type': 'menu',
          'menus': menus,
          'isFollowUp': isFollowUp,
          'disabled': false,
        });
      });
      _scrollDown();
    } catch (_) {}
  }

  Future<void> _sendMenu(int menuNumber, int itemIndex) async {
    setState(() => _items[itemIndex]['disabled'] = true);
    try {
      final data = await ChatbotService.getResponse(menuNumber);
      setState(() {
        _items.add({
          'type': 'bot',
          'text':
              '${data['title']}\n\n${data['response'] ?? 'Informasi belum tersedia.'}',
        });
      });
      _scrollDown();
      await Future.delayed(const Duration(milliseconds: 600));
      await _loadMenu(isFollowUp: true);
    } catch (_) {}
  }

  void _endChat(int itemIndex) {
    setState(() {
      _items[itemIndex]['disabled'] = true;
      _items.add({
        'type': 'bot',
        'text':
            "Jazakallahu khairan atas kunjungannya 🙏\n\nSemoga Allah memudahkan langkah Anda menuju Baitullah. Jika suatu saat ada yang ingin ditanyakan kembali, kami selalu siap membantu.\n\nWassalamu'alaikum Warahmatullahi Wabarakatuh.",
      });
    });
    _scrollDown();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _anim.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  IconData _menuIcon(int n) {
    const icons = [
      Icons.mosque,
      Icons.mosque_outlined,
      Icons.location_on,
      Icons.location_on,
      Icons.location_on,
      Icons.flight,
      Icons.hotel,
      Icons.attach_money,
      Icons.book,
    ];
    return n <= icons.length ? icons[n - 1] : Icons.info_outline;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _slide.value),
        child: Opacity(opacity: _fade.value, child: child),
      ),
      child: Container(
        width: 300,
        height: MediaQuery.of(context).size.height * 0.60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.35)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 25,
              spreadRadius: 0,
              offset: const Offset(0, 25),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.6),
              blurRadius: 0,
              spreadRadius: 0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // ── BACKGROUND IMAGE ──
              Positioned.fill(
                child: Image.asset(
                  'assets/images/cb-bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              // ── GLASS OVERLAY ──
              Positioned.fill(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(color: Colors.transparent),
                ),
              ),
              // ── KONTEN ──
              Column(
                children: [
                  _buildHeader(),
                  Expanded(child: _buildBody()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          // Avatar — logo-cbb.png
          Stack(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: kGoldDark.withOpacity(0.5), width: 1.5),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo-cbb.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: const Color(0xFF27AE60),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Asisten RAVOLA',
                  style: TextStyle(
                    color: const Color(0xFFB8860B),
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    fontFamily: 'Georgia',
                    shadows: [
                      Shadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const Text(
                  '● ONLINE',
                  style: TextStyle(
                    color: Color(0xFF27AE60),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: widget.onClose,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: kGoldDark.withOpacity(0.4)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(Icons.close, size: 13, color: Color(0xFFB8860B)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return ListView.separated(
      controller: _scrollCtrl,
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
      itemCount: _items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final item = _items[i];
        if (item['type'] == 'bot') return _buildBotBubble(item);
        if (item['type'] == 'menu') return _buildMenuList(item, i);
        return const SizedBox();
      },
    );
  }

  Widget _buildBotBubble(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFF3E8D5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✦ bintang emas (pengganti .flower SVG)
          const Text(
            '✦',
            style: TextStyle(
              color: Color(0xFFD4AF37),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item['text'],
              style: const TextStyle(
                fontSize: 10.5,
                color: Color(0xFF4A4A4A),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(Map<String, dynamic> item, int itemIndex) {
    final menus = item['menus'] as List<ChatMenu>;
    final disabled = item['disabled'] as bool;
    final isFollowUp = item['isFollowUp'] as bool;

    return Column(
      children: [
        ...menus.map((m) => _buildMenuCard(
              number: m.menuNumber,
              title: m.title,
              disabled: disabled,
              onTap: () => _sendMenu(m.menuNumber, itemIndex),
            )),
        if (isFollowUp)
          _buildMenuCard(
            number: 10,
            title: 'Tidak, saya sudah cukup',
            disabled: disabled,
            isClose: true,
            onTap: () => _endChat(itemIndex),
          ),
      ],
    );
  }

  Widget _buildMenuCard({
    required int number,
    required String title,
    required bool disabled,
    required VoidCallback onTap,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: disabled ? 0.45 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xFFF3ECE5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kGold.withOpacity(0.25)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Left gold line
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF5B400), Color(0xFFC98A00)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 12, 10),
                child: Row(
                  children: [
                    // Icon circle
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Colors.white, Color(0xFFF0E6D7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: kGold.withOpacity(0.4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        isClose ? Icons.check : _menuIcon(number),
                        color: const Color(0xFFC98A00),
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$number.  ',
                              style: const TextStyle(
                                color: Color(0xFFC98A00),
                                fontWeight: FontWeight.w600,
                                fontSize: 12.5,
                              ),
                            ),
                            TextSpan(
                              text: title,
                              style: const TextStyle(
                                color: Color(0xFF3B2A1A),
                                fontSize: 12.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Arrow >
                    Transform.rotate(
                      angle: 0.785,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color(0xFFC98A00), width: 2),
                            right: BorderSide(color: Color(0xFFC98A00), width: 2),
                          ),
                        ),
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
}