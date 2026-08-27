import 'package:flutter/material.dart';

/// Data đơn giản cho danh thiếp — tập trung luyện style, chưa cần API.
class BusinessCardData {
  const BusinessCardData({
    required this.name,
    required this.job,
    required this.email,
    required this.phone,
    required this.skills,
  });

  final String name;
  final String job;
  final String email;
  final String phone;
  final String skills;
}

const fakeBusinessCard = BusinessCardData(
  name: 'Nguyen Van A',
  job: 'Flutter Developer',
  email: 'nguyenvana@email.com',
  phone: '+84 912 345 678',
  skills: 'Dart · Flutter · UI Layout',
);

/// Danh thiếp — luyện TextStyle + BoxDecoration (Ngày 5).
///
/// TextStyle: chỉnh chữ (size, weight, color, height).
/// BoxDecoration: trang trí hộp (color, border, borderRadius, boxShadow, gradient).
/// Lưu ý: KHÔNG dùng đồng thời Container.color và decoration.
class BusinessCard extends StatelessWidget {
  const BusinessCard({
    super.key,
    required this.data,
  });

  final BusinessCardData data;

  @override
  Widget build(BuildContext context) {
    // Chỉ dùng decoration — color nằm bên trong BoxDecoration.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // Row: avatar trái + thông tin phải (layout Ngày 4).
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Avatar(),
          const SizedBox(width: 16),
          // Expanded: phần chữ chiếm hết chiều ngang còn lại, tránh overflow.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Hierarchy: tên > nghề > liên hệ > kỹ năng.
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.job,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigo.shade700,
                  ),
                ),
                const SizedBox(height: 12),
                _ContactRow(icon: Icons.email_outlined, label: data.email),
                const SizedBox(height: 6),
                _ContactRow(icon: Icons.phone_outlined, label: data.phone),
                const SizedBox(height: 12),
                Text(
                  data.skills,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.indigo.shade100,
      child: Icon(
        Icons.person,
        size: 44,
        color: Colors.indigo.shade700,
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.indigo.shade400),
        const SizedBox(width: 8),
        // Expanded + ellipsis: email/phone dài không làm tràn ngang.
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
