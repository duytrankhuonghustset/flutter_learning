import 'package:flutter/material.dart';

/// Ngày 24 Lab 2: chuyển từ lib/ vào lib/screens/.
/// Phòng thí nghiệm Style — luyện TextStyle, BoxDecoration, shadow, gradient.
class StyleLabScreen extends StatelessWidget {
  const StyleLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Style Lab'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ExperimentCard(
            title: '1) TextStyle hierarchy — tên / nghề / bio',
            explanation:
                'Chữ cần có thứ bậc: tên lớn + đậm, nghề vừa, bio nhỏ + nhạt. '
                'Nhìn 1 giây vẫn biết đâu là tên.',
            child: _TextHierarchyLab(),
          ),
          SizedBox(height: 16),
          _ExperimentCard(
            title: '2) Lỗi color + decoration — và cách sửa',
            explanation:
                'Container không cho vừa color vừa decoration (assert). '
                'Đưa màu vào trong BoxDecoration cùng borderRadius.',
            child: _ColorDecorationLab(),
          ),
          SizedBox(height: 16),
          _ExperimentCard(
            title: '3) Border + BorderRadius',
            explanation:
                'border vẽ viền; borderRadius bo góc. '
                'Cả hai nằm trong BoxDecoration (không dùng property color bên ngoài).',
            child: _BorderRadiusLab(),
          ),
          SizedBox(height: 16),
          _ExperimentCard(
            title: '4) BoxShadow nhẹ',
            explanation:
                'color = độ đậm bóng, blurRadius = độ mờ/lan, offset = hướng lệch. '
                'Bóng nhẹ giúp card “nổi” mà không nặng.',
            child: _BoxShadowLab(),
          ),
          SizedBox(height: 16),
          _ExperimentCard(
            title: '5) LinearGradient (optional)',
            explanation:
                'gradient thay cho color đơn trong BoxDecoration. '
                'Dùng begin/end để chọn hướng chuyển màu.',
            child: _LinearGradientLab(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Card bọc mỗi thí nghiệm
// ---------------------------------------------------------------------------

class _ExperimentCard extends StatelessWidget {
  const _ExperimentCard({
    required this.title,
    required this.explanation,
    required this.child,
  });

  final String title;
  final String explanation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              explanation,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1) TextStyle hierarchy
// ---------------------------------------------------------------------------

class _TextHierarchyLab extends StatelessWidget {
  const _TextHierarchyLab();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade100),
      ),
      child: const Column(
        children: [
          Text(
            'Nguyen Van A',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.2,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Thich xay app dep, code sach va hoc moi ngay.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2) color + decoration: sai vs đúng
// ---------------------------------------------------------------------------

class _ColorDecorationLab extends StatelessWidget {
  const _ColorDecorationLab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Không chạy được đoạn SAI (assert). Chỉ ghi chú để học.
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Text(
            'SAI (đừng chạy):\n'
            'Container(\n'
            '  color: Colors.blue,          // ❌ xung đột\n'
            '  decoration: BoxDecoration(\n'
            '    borderRadius: BorderRadius.circular(12),\n'
            '  ),\n'
            ')',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Colors.red.shade900,
              height: 1.35,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'ĐÚNG — color nằm trong decoration:',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 8),
        // Cách sửa: chỉ dùng decoration, color bên trong BoxDecoration.
        Container(
          height: 72,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'color + borderRadius trong BoxDecoration',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 3) Border + BorderRadius
// ---------------------------------------------------------------------------

class _BorderRadiusLab extends StatelessWidget {
  const _BorderRadiusLab();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 88,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.indigo, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'radius 8',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 88,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              border: Border.all(color: Colors.indigo.shade300, width: 2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Text(
              'radius 24',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 4) BoxShadow nhẹ
// ---------------------------------------------------------------------------

class _BoxShadowLab extends StatelessWidget {
  const _BoxShadowLab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: const Column(
          children: [
            Text(
              'Card co bong nhe',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'blurRadius: 10 · offset: (0, 4) · alpha: 0.12',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5) LinearGradient
// ---------------------------------------------------------------------------

class _LinearGradientLab extends StatelessWidget {
  const _LinearGradientLab();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo,
            Colors.teal,
          ],
        ),
      ),
      child: const Text(
        'LinearGradient: indigo → teal',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
