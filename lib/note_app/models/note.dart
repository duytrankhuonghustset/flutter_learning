/// Một ghi chú lưu trên máy.
class Note {
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Dòng phụ trên danh sách khi chưa có nội dung.
  String get preview {
    final text = content.trim();
    if (text.isEmpty) return 'Chưa có nội dung';
    return text.replaceAll(RegExp(r'\s+'), ' ');
  }

  Note copyWith({
    String? title,
    String? content,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

/// Lọc theo tiêu đề hoặc nội dung. Query rỗng trả về cả danh sách.
List<Note> filterNotes(List<Note> notes, String query) {
  final needle = query.trim().toLowerCase();
  if (needle.isEmpty) return List<Note>.from(notes);
  return notes.where((note) {
    return note.title.toLowerCase().contains(needle) ||
        note.content.toLowerCase().contains(needle);
  }).toList();
}

/// Mới sửa lên trước.
List<Note> sortNotesByUpdated(List<Note> notes) {
  final copy = List<Note>.from(notes);
  copy.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  return copy;
}

String formatNoteTime(DateTime time) {
  final local = time.toLocal();
  final now = DateTime.now();
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  final clock = '$hour:$minute';
  final sameDay =
      now.year == local.year && now.month == local.month && now.day == local.day;
  if (sameDay) return clock;
  return '${local.day}/${local.month}/${local.year} $clock';
}
