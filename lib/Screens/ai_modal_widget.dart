import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

      final String mlUrl =
          dotenv.env['FLASK_ENGINE_URL'] ?? 'https://ravola.pythonanywhere.com';

      final response = await http.post(
        Uri.parse('$mlUrl/predict'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'fase': 1, 'saldo': budget, 'income': saving}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _isLoading = false;
          _showResult = true;
          _predictionData = data;
        });
      } else {
        throw Exception('Server Error');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal terhubung ke server AI.')),
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
                    child: const Icon(
                      Icons.mosque,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PREDIKSI FINANSIAL &\nKEBERANGKATAN HAJI',
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
              _buildInputLabel('INCOME PER BULAN'),
              const SizedBox(height: 6),
              _buildRpInput(_savingCtrl, '2.000.000'),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _isLoading ? null : _process,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _isLoading
                          ? [Colors.grey.shade700, Colors.grey.shade600]
                          : [const Color(0xFFFFD54F), const Color(0xFFFF3D00)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: _isLoading
                        ? []
                        : [
                            BoxShadow(
                              color: const Color(0xFFFF6D00).withOpacity(0.45),
                              blurRadius: 14,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isLoading
                            ? Icons.hourglass_empty
                            : Icons.arrow_forward,
                        color: _isLoading ? Colors.grey.shade400 : Colors.black,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isLoading ? 'MEMPROSES...' : 'MULAI ANALISIS',
                        style: TextStyle(
                          color: _isLoading
                              ? Colors.grey.shade400
                              : Colors.black,
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
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'Analisis berdasarkan data historis harga Haji ',
                            ),
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
          height: _showResult ? 550 : 320,
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

    final namaBulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    final bisaDaftarSekarang = data['bisa_daftar_sekarang'] == true;
    final daftarMonth = data['daftar_month'] as int;
    final daftarYear = data['daftar_year'] as int;
    final berangkatYear = data['berangkat_year'] as int;
    final bulanLagi = data['bulan_menuju_daftar'] as int;
    final bipihPred = data['bipih_pred'] as int;
    final sisaPelunasan = data['sisa_pelunasan'] as int;

    final fmt = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    final opsiLabel = [
      {'key': 'opsi1', 'label': 'Santai', 'desc': 'Lunas tepat waktu'},
      {'key': 'opsi2', 'label': 'Stabil', 'desc': 'Lunas 5 th lebih cepat'},
      {'key': 'opsi3', 'label': 'Agresif', 'desc': 'Lunas 10 th lebih cepat'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── FASE 1
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kGold.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FASE 1 — KAPAN BISA DAFTAR?',
                style: TextStyle(
                  color: kGold,
                  fontSize: 9,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              if (bisaDaftarSekarang) ...[
                const Text(
                  ' Saldo Anda sudah mencukupi setoran awal Rp 25.000.000.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
                Text(
                  ' Anda bisa daftar sekarang (${namaBulan[daftarMonth - 1]} $daftarYear).',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
              ] else ...[
                const Text(
                  ' Saldo belum mencapai Rp 25.000.000.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
                Text(
                  ' Anda bisa daftar pada ${namaBulan[daftarMonth - 1]} $daftarYear ($bulanLagi bulan lagi).',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
              ],
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 11, height: 1.5),
                  children: [
                    const TextSpan(
                      text: ' Estimasi keberangkatan: ',
                      style: TextStyle(color: Colors.white70),
                    ),
                    TextSpan(
                      text: '$berangkatYear',
                      style: const TextStyle(
                        color: kGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: ' (masa tunggu 26 tahun).',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // ── FASE 2 header
        const Text(
          'FASE 2 — PREDIKSI & CICILAN',
          style: TextStyle(
            color: kGold,
            fontSize: 9,
            letterSpacing: 2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),

        // ── 2 card BIPIH & Sisa
        Row(
          children: [
            Expanded(
              child: _infoCard(
                'Prediksi BIPIH $berangkatYear',
                fmt.format(bipihPred),
                const Color(0xFFFFF176),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _infoCard(
                'Sisa Setelah Setoran Awal',
                fmt.format(sisaPelunasan),
                const Color(0xFFFFAB40),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // ── 3 opsi cicilan
        const Text(
          'PILIHAN CICILAN PELUNASAN',
          style: TextStyle(color: Colors.grey, fontSize: 9, letterSpacing: 2),
        ),
        const SizedBox(height: 8),

        ...opsiLabel.map((o) {
          final op = data[o['key']] as Map<String, dynamic>;
          final perBulan = fmt.format(op['per_bulan']);
          final lunasM = namaBulan[(op['lunas_month'] as int) - 1];
          final lunasY = op['lunas_year'];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kGold.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        o['label']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${o['desc']} — lunas $lunasM $lunasY',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: perBulan,
                        style: const TextStyle(
                          color: kGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const TextSpan(
                        text: '/bln',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 12),

        // ── Tombol reset
        GestureDetector(
          onTap: _reset,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: const Center(
              child: Text(
                'Hitung Ulang',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoCard(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kGold.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 9,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
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
              border: Border.all(
                color: const Color(0xFFFFB400).withOpacity(0.6),
              ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contoh:',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 9,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                TextField(
                  controller: ctrl,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(bottom: 4),
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
//  SMALL WIDGETS & PAINTERS (Sama seperti sebelumnya)
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
