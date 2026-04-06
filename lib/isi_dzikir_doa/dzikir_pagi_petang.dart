import 'package:flutter/material.dart';

class DzikirPagiPetangScreen extends StatelessWidget {
  final bool isDark;
  const DzikirPagiPetangScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg          = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr     = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final textKotakClr = isDark ? const Color(0xFF000000) : const Color(0xFFE0C070);
    final appBarBg    = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr    = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    Widget bulletList(List<String> items) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ', style: TextStyle(fontSize: 15, color: textClr)),
                        Expanded(child: Text(item, style: TextStyle(fontSize: 15, color: textClr))),
                      ],
                    ),
                  ))
              .toList(),
        );

    Widget noteBox(List<String> notes) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E7),
            borderRadius: BorderRadius.circular(8),
            border: const Border(left: BorderSide(color: Color(0xFFE6A63C), width: 4)),
          ),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(top: 8, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: notes
                .map((note) => Text(note, style: TextStyle(fontSize: 14, height: 1.57, color: textKotakClr)))
                .toList(),
          ),
        );

    return Scaffold(
      backgroundColor: bg,
      body: Column(
        children: [
          Container(
            height: 95,
            color: appBarBg,
            child: SafeArea(
              bottom: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6, left: 8),
                      child: Text('←', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: titleClr)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Dzikir Pagi & Petang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: titleClr)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dzikir Pagi & Petang',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE6A63C), height: 1.5),
                  ),
                  const SizedBox(height: 16),

                  // 1
                  Text('1. Al-Ikhlas, Al-Falaq, An-Nas (3x)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr)),
                  const SizedBox(height: 8),
                  bulletList(['QS. Al-Ikhlas', 'QS. Al-Falaq', 'QS. An-Nas']),
                  noteBox([
                    '📌 Dibaca masing-masing 3 kali pagi dan petang.',
                    'Keutamaan: Perlindungan dari segala kejahatan.',
                  ]),
                  const SizedBox(height: 20),

                  // 2
                  Text('2. Tasbih, Tahmid, Takbir', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr)),
                  const SizedBox(height: 8),
                  bulletList(['Subhanallah (33x)', 'Alhamdulillah (33x)', 'Allahu Akbar (34x)']),
                  noteBox(['📌 Menghapus dosa dan menenangkan hati.']),
                  const SizedBox(height: 20),

                  // 3
                  Text('3. Dzikir Perlindungan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textClr)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Text(
                      'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ...',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textClr, height: 1.8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      text: 'Artinya:\n',
                      style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                      children: const [
                        TextSpan(
                          text: '"Dengan nama Allah yang bersama nama-Nya tidak ada sesuatu pun yang membahayakan…"',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  noteBox(['📌 Dibaca 3x pagi & petang.']),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}