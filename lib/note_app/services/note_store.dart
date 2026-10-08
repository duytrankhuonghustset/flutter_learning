import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_learning/note_app/models/note.dart';

/// Một khóa JSON. Đổi tên khóa là bỏ dữ liệu cũ.
const notesStorageKey = 'notes_v1';

/// Đọc/ghi danh sách ghi chú. Widget không gọi SharedPreferences trực tiếp.
class NoteStore {
  Future<SharedPreferences> _prefs() => SharedPreferences.getInstance();

  Future<List<Note>> load() async {
    final prefs = await _prefs();
    final raw = prefs.getString(notesStorageKey);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw);
    if (decoded is! List) return [];

    final notes = <Note>[];
    for (final item in decoded) {
      if (item is Map<String, dynamic>) {
        notes.add(Note.fromJson(item));
      } else if (item is Map) {
        notes.add(Note.fromJson(Map<String, dynamic>.from(item)));
      }
    }
    return sortNotesByUpdated(notes);
  }

  Future<void> saveAll(List<Note> notes) async {
    final prefs = await _prefs();
    final encoded = jsonEncode(notes.map((note) => note.toJson()).toList());
    await prefs.setString(notesStorageKey, encoded);
  }
}
