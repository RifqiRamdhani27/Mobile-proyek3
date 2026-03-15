import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();

    _messages.add({
      "text":
          "Assalamualaikum Warahmatullahi Wabarakatuh.\nAku Asisten Pribadi RAVOLA.",
      "isUser": false,
    });

    _messages.add({"text": "Apa ada yang bisa saya bantu?", "isUser": false});
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    String messageText = _controller.text.trim();

    setState(() {
      _messages.add({"text": messageText, "isUser": true});
    });

    _controller.clear();

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/chatbot"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": messageText}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _messages.add({"text": data["answer"], "isUser": false});
        });
      } else {
        setState(() {
          _messages.add({
            "text": "Terjadi kesalahan pada server.",
            "isUser": false,
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          "text": "Tidak bisa terhubung ke server.",
          "isUser": false,
        });
      });
    }

    _controller.clear();

    // Scroll ke bawah setelah pesan terkirim});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(backgroundColor: const Color(0xFFF4B400), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE6A63C), width: 3),
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Header
              Row(
                children: const [
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/images/chatbot.png"),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Asisten RAVOLA",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              const Divider(),

              // Chat Area
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final bool isUser = message["isUser"];

                    return Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(12),
                        constraints: const BoxConstraints(maxWidth: 250),
                        decoration: BoxDecoration(
                          color: isUser
                              ? const Color(0xFFE6A63C)
                              : const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          message["text"],
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Input Area
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFE6A63C),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (value) {
                            _sendMessage();
                          },
                          decoration: const InputDecoration(
                            hintText: "Masukkan Pesan",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Color(0xFFE6A63C)),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
