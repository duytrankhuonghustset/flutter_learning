import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_learning/note_app/models/note.dart';
import 'package:flutter_learning/note_app/services/note_store.dart';
import 'package:flutter_learning/note_app/state/notes_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Note _note({
  required String id,
  required String title,
  required String content,
  required DateTime updatedAt,
}) {
  return Note(
    id: id,
    title: title,
    content: content,
    createdAt: updatedAt,
    updatedAt: updatedAt,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('filterNotes khớp tiêu đề và nội dung, bỏ qua hoa thường', () {
    final notes = [
      _note(
        id: '1',
        title: 'Mua sữa',
        content: 'Sữa tươi',
        updatedAt: DateTime(2026, 1, 1),
      ),
      _note(
        id: '2',
        title: 'Họp',
        content: 'Gửi báo cáo tuần',
        updatedAt: DateTime(2026, 1, 2),
      ),
    ];

    expect(filterNotes(notes, '  ').map((n) => n.id), ['1', '2']);
    expect(filterNotes(notes, 'SỮA').map((n) => n.id), ['1']);
    expect(filterNotes(notes, 'báo cáo').map((n) => n.id), ['2']);
    expect(filterNotes(notes, 'xyz'), isEmpty);
  });

  test('CRUD lưu xuống SharedPreferences và đọc lại', () async {
    SharedPreferences.setMockInitialValues({});
    final controller = NotesController(NoteStore());
    await controller.load();
    expect(controller.notes, isEmpty);
    expect(controller.loading, isFalse);

    final created = await controller.create(title: ' Ý tưởng ', content: ' Viết app ');
    expect(created.title, 'Ý tưởng');
    expect(created.content, 'Viết app');
    expect(controller.notes, hasLength(1));

    await controller.update(created, title: 'Ý tưởng 2', content: 'Tìm kiếm');
    expect(controller.notes.single.title, 'Ý tưởng 2');
    expect(controller.notes.single.content, 'Tìm kiếm');
    expect(controller.notes.single.id, created.id);

    final reloaded = NotesController(NoteStore());
    await reloaded.load();
    expect(reloaded.notes.single.title, 'Ý tưởng 2');

    await reloaded.delete(created.id);
    expect(reloaded.notes, isEmpty);

    final afterDelete = NotesController(NoteStore());
    await afterDelete.load();
    expect(afterDelete.notes, isEmpty);
  });
}
