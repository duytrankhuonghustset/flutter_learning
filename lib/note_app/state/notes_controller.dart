import 'package:flutter/foundation.dart';

import 'package:flutter_learning/note_app/models/note.dart';
import 'package:flutter_learning/note_app/services/note_store.dart';

/// Danh sách ghi chú trên bộ nhớ, đồng bộ xuống máy sau mỗi thay đổi.
class NotesController extends ChangeNotifier {
  NotesController(this._store);

  final NoteStore _store;

  List<Note> notes = [];
  bool loading = true;
  String? error;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      notes = await _store.load();
    } catch (e) {
      error = 'Không đọc được ghi chú đã lưu.';
      notes = [];
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<Note> create({required String title, required String content}) async {
    final now = DateTime.now();
    final note = Note(
      id: now.microsecondsSinceEpoch.toString(),
      title: title.trim(),
      content: content.trim(),
      createdAt: now,
      updatedAt: now,
    );
    notes = sortNotesByUpdated([note, ...notes]);
    notifyListeners();
    await _store.saveAll(notes);
    return note;
  }

  Future<void> update(Note note, {required String title, required String content}) async {
    final next = note.copyWith(
      title: title.trim(),
      content: content.trim(),
      updatedAt: DateTime.now(),
    );
    notes = sortNotesByUpdated([
      for (final item in notes)
        if (item.id == note.id) next else item,
    ]);
    notifyListeners();
    await _store.saveAll(notes);
  }

  Future<void> delete(String id) async {
    notes = notes.where((note) => note.id != id).toList();
    notifyListeners();
    await _store.saveAll(notes);
  }
}
