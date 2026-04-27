import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const Color kGold = Color(0xFFF5B400);
const Color kGoldLight = Color(0xFFFFF8E1);
const Color kDark = Color(0xFF1A1200);
const Color kGoldDark = Color(0xFFD4A017);

void showMLModal(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.82),
    barrierDismissible: true,
    builder: (_) => const _MLModal(),
  );
}

class _MLModal extends StatefulWidget {
  const _MLModal();
  @override
  State<_MLModal> createState() => _MLModalState();
}

class _MLModalState extends State<_MLModal>
    with SingleTickerProviderStateMixin {
  final _budgetCtrl = TextEditingController();
  final _savingCtrl = TextEditingController();
  bool _showResult = false;
  bool _isLoading = false;
  late AnimationController _spinCtrl;
  Map<String, dynamic>? _predictionData;

  @override
  void initState() {
    super.initState();
    _spinCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _spinCtrl.dispose();
    _budgetCtrl.dispose();
    _savingCtrl.dispose();
    super.dispose();
  }

  void _process() async {
    if (_budgetCtrl.text.isEmpty || _savingCtrl.text.isEmpty) return;
    setState(() => _isLoading = true);

    try {
      final budget = _budgetCtrl.text.replaceAll('.', '');
      final saving = _savingCtrl.text.replaceAll('.', '');

      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/predict'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'budget': budget, 'saving': saving}),
      );

      final data = jsonDecode(response.body);

      setState(() {
        _isLoading = false;
        _showResult = true;
        _predictionData = data;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal terhubung ke server.')),
        );
      }
    }
  }

  void _reset() => setState(() {
        _showResult = false;
        _predictionData = null;
        _budgetCtrl.clear();
        _savingCtrl.clear();
      });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFFFFD700).withOpacity(0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF9500).withOpacity(0.3),
              blurRadius: 30,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(29),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [_buildLeft(), const _GoldDivider(), _buildRight()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeft() {
    return Stack(
      children: [
        SizedBox(
          height: 470,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/kabah.jpg',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.45),
                colorBlendMode: BlendMode.darken,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xB3720000),
                      Color(0xCC000000),
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFCC00), Color(0xFFFF6D00)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.mosque, color: Colors.black, size: 18),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PREDIKSI FINANSIAL HAJI',
                        style: TextStyle(
                          color: Color(0xFFFFF176),
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Machine Learning Forecast',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Perencanaan Finansial',
                style: TextStyle(
                  color: Color(0xFFFFF176),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              const _GoldDividerH(),
              const SizedBox(height: 16),
              _buildInputLabel('BUDGET SAAT INI'),
              const SizedBox(height: 6),
              _buildRpInput(_budgetCtrl, '2.000.000'),
              const SizedBox(height: 14),
              _buildInputLabel('NABUNG PER BULAN'),
              const SizedBox(height: 6),
              _buildRpInput(_savingCtrl, '2.000.000'),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _process,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD54F), Color(0xFFFF3D00)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF6D00).withOpacity(0.45),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_forward, color: Colors.black, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'MULAI ANALISIS',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kGold.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.workspace_premium, color: kGold, size: 14),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.grey, fontSize: 10, height: 1.5),
                          children: [
                            TextSpan(text: 'Analisis berdasarkan data historis harga Haji '),
                            TextSpan(
                              text: '16 tahun',
                              style: TextStyle(
                                color: Color(0xFFFFF176),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: ' terakhir.'),
                          ],
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
    );
  }

  Widget _buildRight() {
    return Stack(
      children: [
        SizedBox(
          height: _showResult ? 530 : 320,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(color: const Color(0xFF0D0A00)),
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.8, -0.8),
                    radius: 0.8,
                    colors: [Color(0x44FFB400), Colors.transparent],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(-0.8, 0.8),
                    radius: 0.8,
                    colors: [Color(0x44FF3D00), Colors.transparent],
                  ),
                ),
              ),
              CustomPaint(painter: _DotPatternPainter()),
            ],
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: kGold.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: kGold.withOpacity(0.4)),
              ),
              child: const Icon(Icons.close, color: kGold, size: 16),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _showResult ? _buildResult() : _buildLoading(),
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        SizedBox(
          width: 80,
          height: 80,
          child: _isLoading
              ? RotationTransition(
                  turns: _spinCtrl,
                  child: CustomPaint(painter: _SpinnerPainter()),
                )
              : CustomPaint(painter: _SpinnerPainter(static: true)),
        ),
        const SizedBox(height: 16),
        Text(
          _isLoading ? 'Memproses Data...' : 'Menunggu Input Data...',
          style: const TextStyle(
            color: Color(0xFFE0E0E0),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'AI sedang memproses data untuk prediksi terbaik Anda',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 11, height: 1.5),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildResult() {
    final data = _predictionData;
    if (data == null) return const SizedBox();

    final targetYear = data['haji_year'].toString();
    final currentYear = 2026;
    final gap = targetYear == '2045+'
        ? 25
        : (int.tryParse(targetYear) ?? 2045) - currentYear;

    final slope = (double.tryParse(data['slope'].toString()) ?? 0) * 1000000;
    final slopeFormatted = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(slope);

    String message;
    if (gap <= 3) {
      message = 'Perencanaan finansial Anda sangat matang. Target $targetYear sangat presisi untuk diraih.';
    } else if (gap <= 10) {
      message = 'Anda berada di jalur tepat untuk keberangkatan tahun $targetYear. Terus pertahankan konsistensi.';
    } else if (gap <= 20) {
      message = 'Sistem memproyeksikan keberangkatan tahun $targetYear. Pertimbangkan alokasi pendapatan tambahan.';
    } else {
      message = 'Proyeksi berada pada tahun $targetYear. Tinjau kembali alokasi bulanan untuk memperkuat daya simpan.';
    }

    return Column(
      children: [
        const Text(
          'Estimasi Keberangkatan',
          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          targetYear,
          style: const TextStyle(
            color: Color(0xFFF5B400),
            fontSize: 56,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kGold.withOpacity(0.2)),
          ),
          child: CustomPaint(painter: _SimpleBarChartPainter()),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kGold.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Analisis Machine Learning (Akurasi 97.80%):',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '• Tren Rutin: Eskalasi biaya ±$slopeFormatted/tahun.',
                style: const TextStyle(color: Colors.grey, fontSize: 10, height: 1.6),
              ),
              const Text(
                '• Kebijakan: Penyesuaian subsidi ±Rp 10.000.000 (Pasca 2023).',
                style: TextStyle(color: Colors.grey, fontSize: 10, height: 1.6),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _reset,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Center(
                    child: Text('Tutup', style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD54F), Color(0xFFFF6D00)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Simpan Jadwal',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 9,
        letterSpacing: 2,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildRpInput(TextEditingController ctrl, String hint) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A0A00).withOpacity(0.8),
            Colors.black.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFAA00).withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8C00).withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                center: Alignment(-0.3, -0.3),
                colors: [Color(0xFF2A2A2A), Colors.black],
              ),
              border: Border.all(color: const Color(0xFFFFB400).withOpacity(0.6)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFAA00).withOpacity(0.4),
                  blurRadius: 10,
                ),
                const BoxShadow(
                  color: Color(0x66FF8C00),
                  blurRadius: 10,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Rp',
                style: TextStyle(
                  color: Color(0xFFFFF176),
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Contoh:', style: TextStyle(color: Colors.grey, fontSize: 9)),
                TextField(
                  controller: ctrl,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  inputFormatters: [_RupiahFormatter()],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
//  SMALL WIDGETS
// ══════════════════════════════════════════════════════════════════

class _GoldDivider extends StatelessWidget {
  const _GoldDivider();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Color(0xFFF5B400), Colors.transparent],
        ),
      ),
    );
  }
}

class _GoldDividerH extends StatelessWidget {
  const _GoldDividerH();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 2),
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kGold.withOpacity(0.6), Colors.transparent],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
//  CUSTOM PAINTERS
// ══════════════════════════════════════════════════════════════════

class _SpinnerPainter extends CustomPainter {
  final bool static_;
  _SpinnerPainter({bool static = false}) : static_ = static;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2, cy = size.height / 2, r = size.width * 0.4;
    canvas.drawCircle(
      Offset(cx, cy),
      r,
      Paint()
        ..color = const Color(0xFF333333)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );
    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: r);
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFFCC00), Color(0xFFFF3D00)],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, -1.5, 4.5, false, paint);
  }

  @override
  bool shouldRepaint(_) => true;
}

class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFFFCC00).withOpacity(0.08);
    const spacing = 30.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _SimpleBarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const bars = [0.4, 0.55, 0.5, 0.65, 0.6, 0.75, 0.85, 1.0];
    final barW = size.width / (bars.length * 2);
    final paint = Paint()..strokeCap = StrokeCap.round;

    for (int i = 0; i < bars.length; i++) {
      final x = i * barW * 2 + barW * 0.5;
      final barH = size.height * 0.75 * bars[i];
      final y = size.height * 0.85 - barH;

      paint.shader = LinearGradient(
        colors: [
          const Color(0xFFFFD54F).withOpacity(0.9),
          const Color(0xFFFF3D00).withOpacity(0.7),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(x, y, barW * 1.2, barH));

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barW * 1.2, barH),
          const Radius.circular(3),
        ),
        paint,
      );
    }

    canvas.drawLine(
      Offset(0, size.height * 0.85),
      Offset(size.width, size.height * 0.85),
      Paint()
        ..color = Colors.white24
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

// ══════════════════════════════════════════════════════════════════
//  RUPIAH INPUT FORMATTER
// ══════════════════════════════════════════════════════════════════

class _RupiahFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue old,
    TextEditingValue value,
  ) {
    final digits = value.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return value.copyWith(text: '');
    final n = int.parse(digits);
    final formatted = _fmt(n);
    return value.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _fmt(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}