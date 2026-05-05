import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:flutter_application/config.dart';
import 'package:encrypt/encrypt.dart' as enc;

const Color kGold = Color(0xFFF5B400);
const Color kGoldDark = Color(0xFFD4A017);

// ── MODEL ────────────────────────────────────────────────────────────────────
class ChatMenu {
  final int menuNumber;
  final String title;
  ChatMenu({required this.menuNumber, required this.title});
  factory ChatMenu.fromJson(Map<String, dynamic> j) =>
      ChatMenu(menuNumber: j['menu_number'], title: j['title']);
}

// ── SERVICE DENGAN BYPASS INFINITYFREE ───────────────────────────────────────
class ChatbotService {
  static const String userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36';

  // Fungsi untuk menjebol AES InfinityFree
  static Future<String?> _solveChallenge(String url) async {
    try {
      final res = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': userAgent},
      );
      if (!res.body.contains('slowAES')) return null;

      final regA = RegExp(r'a=toNumbers\("([a-f0-9]+)"\)');
      final regB = RegExp(r'b=toNumbers\("([a-f0-9]+)"\)');
      final regC = RegExp(r'c=toNumbers\("([a-f0-9]+)"\)');

      final a = regA.firstMatch(res.body)?.group(1) ?? '';
      final b = regB.firstMatch(res.body)?.group(1) ?? '';
      final c = regC.firstMatch(res.body)?.group(1) ?? '';

      final key = enc.Key.fromBase16(a);
      final iv = enc.IV.fromBase16(b);
      final ciphertext = enc.Encrypted.fromBase16(c);

      final encrypter = enc.Encrypter(
        enc.AES(key, mode: enc.AESMode.cbc, padding: null),
      );
      final decrypted = encrypter.decryptBytes(ciphertext, iv: iv);
      return decrypted.map((b) => b.toRadixString(16).padLeft(2, '0')).join('');
    } catch (e) {
      print("Bypass Error: $e");
      return null;
    }
  }

  static Future<List<ChatMenu>> getMenu() async {
    final targetUrl = '$BASE_URL/api/chatbot/menu';
    final cookie = await _solveChallenge(targetUrl);

    final res = await http.get(
      Uri.parse('$targetUrl?i=1'),
      headers: {
        'User-Agent': userAgent,
        'Cookie': '__test=$cookie',
        'Accept': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);
      return data.map((e) => ChatMenu.fromJson(e)).toList();
    }
    throw Exception('Gagal load menu: ${res.statusCode}');
  }

  static Future<Map<String, dynamic>> getResponse(int menuNumber) async {
    final targetUrl = '$BASE_URL/api/chatbot';
    final cookie = await _solveChallenge(targetUrl);

    final res = await http.post(
      Uri.parse('$targetUrl?i=1'),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': userAgent,
        'Cookie': '__test=$cookie',
        'Accept': 'application/json',
      },
      body: jsonEncode({'menu_number': menuNumber}),
    );
    if (res.statusCode == 200) return jsonDecode(res.body);
    throw Exception('Gagal ambil respons');
  }
}

// ── UI WIDGET ────────────────────────────────────────────────────────────────
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
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slide = Tween(
      begin: 20.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic));
    _fade = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward();
    _initChat();
  }

  void _initChat() {
    _items.addAll([
      {'type': 'bot', 'text': "Assalamu'alaikum Warahmatullahi Wabarakatuh."},
      {
        'type': 'bot',
        'text':
            "Aku Asisten Pribadi RAVOLA.\nSilakan pilih informasi di bawah ini:",
      },
    ]);
    _loadMenu(isFollowUp: false);
  }

  Future<void> _loadMenu({required bool isFollowUp}) async {
    try {
      final menus = await ChatbotService.getMenu();
      if (!mounted) return;
      setState(() {
        if (isFollowUp) {
          _items.add({
            'type': 'bot',
            'text': 'Ada lagi yang ingin Anda tanyakan?',
          });
        }
        _items.add({
          'type': 'menu',
          'menus': menus,
          'isFollowUp': isFollowUp,
          'disabled': false,
        });
      });
      _scrollDown();
    } catch (e) {
      print("Chatbot UI Error: $e");
    }
  }

  Future<void> _sendMenu(int menuNumber, int itemIndex) async {
    setState(() => _items[itemIndex]['disabled'] = true);
    try {
      final data = await ChatbotService.getResponse(menuNumber);
      if (!mounted) return;
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
    } catch (e) {
      print("Chatbot Send Error: $e");
    }
  }

  void _endChat(int itemIndex) {
    setState(() {
      _items[itemIndex]['disabled'] = true;
      _items.add({
        'type': 'bot',
        'text':
            "Jazakallahu khairan atas kunjungannya 🙏\n\nSemoga Allah memudahkan langkah Anda menuju Baitullah.\n\nWassalamu'alaikum Warahmatullahi Wabarakatuh.",
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
              offset: const Offset(0, 25),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/cb-bg.png',
                  fit: BoxFit.cover,
                ),
              ),
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

  // Header & Bubble tetap sama seperti kodinganmu sebelumnya...
  // (Potong sedikit biar fokus ke logic bypass)

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kGoldDark.withOpacity(0.5)),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo-cbb.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Asisten RAVOLA',
              style: TextStyle(
                color: Color(0xFFB8860B),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: widget.onClose,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return ListView.separated(
      controller: _scrollCtrl,
      padding: const EdgeInsets.all(12),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Text(
        item['text'],
        style: const TextStyle(fontSize: 11, color: Color(0xFF4A4A4A)),
      ),
    );
  }

  Widget _buildMenuList(Map<String, dynamic> item, int itemIndex) {
    final menus = item['menus'] as List<ChatMenu>;
    final disabled = item['disabled'] as bool;
    return Column(
      children: menus
          .map(
            (m) => _buildMenuCard(
              number: m.menuNumber,
              title: m.title,
              disabled: disabled,
              onTap: () => _sendMenu(m.menuNumber, itemIndex),
            ),
          )
          .toList(),
    );
  }

  Widget _buildMenuCard({
    required int number,
    required String title,
    required bool disabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Opacity(
        opacity: disabled ? 0.5 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: kGold.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(_menuIcon(number), size: 14, color: kGoldDark),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
