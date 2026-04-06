import 'package:flutter/material.dart';

class KewajibanSaatThowafScreen extends StatelessWidget {
  final bool isDark;
  const KewajibanSaatThowafScreen({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    final bg       = isDark ? const Color(0xFF121212) : const Color(0xFFEDEDED);
    final textClr  = isDark ? const Color(0xFFE0C070) : const Color(0xFF1A1A1A);
    final appBarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF4B400);
    final titleClr = isDark ? const Color(0xFFC9A84C) : const Color(0xFF000000);

    final steps = [
      {'title': 'Suci dari hadas dan najis',                      'desc': 'Harus dalam keadaan berwudhu dan pakaian bersih dari najis.'},
      {'title': 'Menutup aurat',                                   'desc': 'Aurat wajib tertutup sesuai ketentuan syariat.'},
      {'title': 'Dilakukan di dalam Masjidil Haram',               'desc': 'Mengelilingi Ka\'bah dari luar bangunan Ka\'bah.'},
      {'title': 'Mengelilingi Ka\'bah sebanyak 7 putaran sempurna','desc': 'Tidak boleh kurang.'},
      {'title': 'Memulai dari Hajar Aswad',                        'desc': 'Dan berakhir di tempat yang sama.'},
      {'title': 'Menjadikan Ka\'bah di sebelah kiri',              'desc': 'Artinya berputar berlawanan arah jarum jam.'},
      {'title': 'Dilakukan secara berurutan (tertib)',              'desc': 'Tidak boleh melompat-lompat putaran.'},
    ];

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
                      child: Text(
                        '←',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: titleClr,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Kewajiban Saat Thowaf',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: titleClr,
                        ),
                      ),
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
                    'Syarat Sah Thowaf',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE6A63C),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Agar thowaf sah, ada beberapa hal yang wajib dipenuhi:',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 4),
                  ...steps.asMap().entries.map((entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24,
                              child: Text(
                                '${entry.key + 1}.',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE6A63C),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.value['title']!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: textClr,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    entry.value['desc']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.57,
                                      color: textClr.withOpacity(0.85),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  Text(
                    'Jika salah satu kewajiban ini tidak terpenuhi, maka thowaf bisa tidak sah dan harus diulang.',
                    style: TextStyle(fontSize: 15, height: 1.6, color: textClr),
                    textAlign: TextAlign.justify,
                  ),
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