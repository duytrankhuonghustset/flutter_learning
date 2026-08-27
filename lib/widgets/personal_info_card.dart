import 'package:flutter/material.dart';
import 'package:flutter_learning/models/profile_data.dart';

/// Card thông tin cá nhân — tổng hợp layout Ngày 4.
///
/// Vai trò widget dùng ở đây:
/// - [Column]: xếp khối theo chiều dọc (avatar → tên → stats → bio → nút).
/// - [Row]: xếp ngang (3 chỉ số, 2 nút).
/// - [Stack] + [Positioned]: chồng badge lên góc avatar.
/// - [Expanded]: chia đều không gian còn lại trong Row.
/// - [SizedBox]: khoảng trống cố định giữa các khối.
/// - [Padding]: đệm quanh nội dung (dùng qua Card/padding, không bọc Container thừa).
class PersonalInfoCard extends StatelessWidget {
  const PersonalInfoCard({
    super.key,
    required this.data,
  });

  final ProfileData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // Padding = đệm quanh nội dung card (không cần Container chỉ để padding).
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Stack: avatar + badge online góc trên-phải.
            const _AvatarWithBadge(),
            const SizedBox(height: 12),
            Text(
              data.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.job,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              data.email,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            // Row + Expanded: 3 chỉ số chia đều chiều ngang.
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.article),
                      const SizedBox(height: 4),
                      _StatItem(label: 'Posts', value: data.posts)
                    ],
                  ),
                ),
                Expanded(
                  child: _StatItem(label: 'Followers', value: data.followers),
                ),
                Expanded(
                  child: _StatItem(label: 'Following', value: data.following),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'About',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 6),
            // Text dài trong Column: tự wrap, không cần Expanded.
            Text(
              data.bio,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            // Row + Expanded: 2 nút rộng bằng nhau.
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: TextButton(onPressed: () {}, child: Text("Messagetoilatoi", overflow: TextOverflow.clip,))
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Share'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Avatar + badge online.
/// Stack chồng lớp; Positioned đặt badge tuyệt đối ở góc.
class _AvatarWithBadge extends StatelessWidget {
  const _AvatarWithBadge();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 88,
      height: 88,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 44,
            backgroundColor: Color(0xFFC5CAE9),
            child: Icon(Icons.person, size: 48, color: Color(0xFF3949AB)),
          ),
          Positioned(
            right: 2,
            top: 2,
            child: SizedBox(
              width: 18,
              height: 18,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(
                    BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Một ô chỉ số trong hàng stats.
class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
  });

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
