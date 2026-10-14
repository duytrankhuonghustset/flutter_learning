import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_learning/note_app/screens/notes_home_page.dart';
import 'package:flutter_learning/note_app/services/note_store.dart';
import 'package:flutter_learning/note_app/state/notes_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('màn trống có nút tạo ghi chú', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final controller = NotesController(NoteStore());
    await controller.load();

    await tester.pumpWidget(
      MaterialApp(home: NotesHomePage(controller: controller)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Chưa có ghi chú'), findsOneWidget);
    expect(find.text('Ghi chú mới'), findsWidgets);
  });
}
