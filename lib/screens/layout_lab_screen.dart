import 'package:flutter/material.dart';

/// Ngày 24 Lab 2: chuyển từ lib/ vào lib/screens/.
/// Phòng thí nghiệm Layout — luyện Column, Row, SizedBox, Padding, Stack.
class LayoutLabScreen extends StatefulWidget {
  const LayoutLabScreen({super.key});

  @override
  State<LayoutLabScreen> createState() => _LayoutLabScreenState();
}

class _LayoutLabScreenState extends State<LayoutLabScreen> {
  MainAxisAlignment _mainAxis = MainAxisAlignment.start;
  CrossAxisAlignment _crossAxis = CrossAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Layout Lab'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ExperimentCard(
            title: '1) Column — mainAxis / crossAxis',
            explanation:
                'mainAxisAlignment xếp theo chiều dọc (trục chính). '
                'crossAxisAlignment xếp theo chiều ngang (trục phụ). '
                'Đổi dropdown bên dưới để thấy sự khác biệt.',
            child: _ColumnAlignmentLab(
              mainAxis: _mainAxis,
              crossAxis: _crossAxis,
              onMainAxisChanged: (value) {
                setState(() => _mainAxis = value);
              },
              onCrossAxisChanged: (value) {
                setState(() => _crossAxis = value);
              },
            ),
          ),
          const SizedBox(height: 16),
          const _ExperimentCard(
            title: '2) Row — Expanded vs Flexible',
            explanation:
                'Expanded bắt buộc chiếm hết phần flex được chia. '
                'Flexible chỉ chiếm tối đa phần đó, có thể nhỏ hơn nếu nội dung ngắn.',
            child: _ExpandedVsFlexibleLab(),
          ),
          const SizedBox(height: 16),
          const _ExperimentCard(
            title: '3) SizedBox vs Padding',
            explanation:
                'SizedBox tạo khoảng trống / kích thước cố định giữa widget. '
                'Padding đẩy nội dung vào trong quanh một widget.',
            child: _SizedBoxVsPaddingLab(),
          ),
          const SizedBox(height: 16),
          const _ExperimentCard(
            title: '4) Stack — avatar + badge',
            explanation:
                'Stack xếp widget chồng lên nhau. '
                'Positioned đặt badge ở góc avatar (góc trên-phải).',
            child: _StackAvatarBadgeLab(),
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
// Thí nghiệm 1: Column alignment
// ---------------------------------------------------------------------------

class _ColumnAlignmentLab extends StatelessWidget {
  const _ColumnAlignmentLab({
    required this.mainAxis,
    required this.crossAxis,
    required this.onMainAxisChanged,
    required this.onCrossAxisChanged,
  });

  final MainAxisAlignment mainAxis;
  final CrossAxisAlignment crossAxis;
  final ValueChanged<MainAxisAlignment> onMainAxisChanged;
  final ValueChanged<CrossAxisAlignment> onCrossAxisChanged;

  static const _mainOptions = <MainAxisAlignment>[
    MainAxisAlignment.start,
    MainAxisAlignment.center,
    MainAxisAlignment.end,
    MainAxisAlignment.spaceBetween,
    MainAxisAlignment.spaceAround,
    MainAxisAlignment.spaceEvenly,
  ];

  static const _crossOptions = <CrossAxisAlignment>[
    CrossAxisAlignment.start,
    CrossAxisAlignment.center,
    CrossAxisAlignment.end,
    CrossAxisAlignment.stretch,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text('mainAxis:'),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButton<MainAxisAlignment>(
                isExpanded: true,
                value: mainAxis,
                items: [
                  for (final option in _mainOptions)
                    DropdownMenuItem(
                      value: option,
                      child: Text(_shortName(option.name)),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) onMainAxisChanged(value);
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text('crossAxis:'),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButton<CrossAxisAlignment>(
                isExpanded: true,
                value: crossAxis,
                items: [
                  for (final option in _crossOptions)
                    DropdownMenuItem(
                      value: option,
                      child: Text(_shortName(option.name)),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) onCrossAxisChanged(value);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Khung cố định để thấy alignment rõ ràng.
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            border: Border.all(color: Colors.indigo.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: mainAxis,
            crossAxisAlignment: crossAxis,
            // Khi crossAxis = stretch: bỏ width cố định để child giãn ngang.
            children: [
              _DemoBox(
                label: 'A',
                color: Colors.red,
                width: crossAxis == CrossAxisAlignment.stretch ? null : 48,
              ),
              _DemoBox(
                label: 'B',
                color: Colors.green,
                width: crossAxis == CrossAxisAlignment.stretch ? null : 80,
              ),
              _DemoBox(
                label: 'C',
                color: Colors.blue,
                width: crossAxis == CrossAxisAlignment.stretch ? null : 64,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static String _shortName(String name) => name;
}

// ---------------------------------------------------------------------------
// Thí nghiệm 2: Expanded vs Flexible
// ---------------------------------------------------------------------------

class _ExpandedVsFlexibleLab extends StatelessWidget {
  const _ExpandedVsFlexibleLab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Expanded (flex: 1) — chiếm hết phần chia:',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const _DemoBox(label: '60', color: Colors.red, width: 60),
            Expanded(
              child: Container(
                height: 40,
                color: Colors.green,
                alignment: Alignment.center,
                child: const Text(
                  'Expanded',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            const _DemoBox(label: '60', color: Colors.blue, width: 60),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Flexible (flex: 1) — tối đa phần chia, không bắt buộc đầy:',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const _DemoBox(label: '60', color: Colors.red, width: 60),
            Flexible(
              child: Container(
                height: 40,
                color: Colors.purple,
                alignment: Alignment.center,
                // Không set width → chỉ rộng bằng chữ.
                child: const Text(
                  'Flexible',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            const _DemoBox(label: '60', color: Colors.blue, width: 60),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '→ Khoảng trống còn lại sau Flexible không bị ép chiếm.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Thí nghiệm 3: SizedBox vs Padding
// ---------------------------------------------------------------------------

class _SizedBoxVsPaddingLab extends StatelessWidget {
  const _SizedBoxVsPaddingLab();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'SizedBox — khoảng trống giữa 2 widget:',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              _DemoBox(label: 'A', color: Colors.teal, width: 48),
              // Khoảng trống cố định giữa A và B.
              SizedBox(width: 24),
              _DemoBox(label: 'B', color: Colors.orange, width: 48),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Padding — đẩy nội dung vào trong quanh 1 widget:',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const ColoredBox(
            color: Colors.amber,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ColoredBox(
                color: Colors.deepOrange,
                child: SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      'Padding 16',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Vàng = vùng padding · Cam = nội dung bên trong.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Thí nghiệm 4: Stack avatar + badge
// ---------------------------------------------------------------------------

class _StackAvatarBadgeLab extends StatelessWidget {
  const _StackAvatarBadgeLab();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Avatar nhỏ + badge online.
        _AvatarWithBadge(
          size: 64,
          badgeSize: 18,
          badgeColor: Colors.green,
        ),
        SizedBox(width: 32),
        // Avatar lớn + badge số thông báo.
        _AvatarWithBadge(
          size: 88,
          badgeSize: 22,
          badgeColor: Colors.red,
          badgeLabel: '3',
        ),
      ],
    );
  }
}

class _AvatarWithBadge extends StatelessWidget {
  const _AvatarWithBadge({
    required this.size,
    required this.badgeSize,
    required this.badgeColor,
    this.badgeLabel,
  });

  final double size;
  final double badgeSize;
  final Color badgeColor;
  final String? badgeLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Avatar.
          CircleAvatar(
            radius: size / 2,
            backgroundColor: Colors.indigo.shade200,
            child: Icon(
              Icons.person,
              size: size * 0.55,
              color: Colors.indigo.shade800,
            ),
          ),
          // Badge góc trên-phải.
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              width: badgeSize,
              height: badgeSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: badgeLabel == null
                  ? null
                  : Text(
                      badgeLabel!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: badgeSize * 0.45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Widget phụ: ô màu demo
// ---------------------------------------------------------------------------

class _DemoBox extends StatelessWidget {
  const _DemoBox({
    required this.label,
    required this.color,
    this.width,
  });

  final String label;
  final Color color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      alignment: Alignment.center,
      color: color,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
