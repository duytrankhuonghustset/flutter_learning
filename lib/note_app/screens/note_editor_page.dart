import 'package:flutter/material.dart';

import 'package:flutter_learning/note_app/models/note.dart';
import 'package:flutter_learning/note_app/state/notes_controller.dart';

/// Kết quả khi đóng màn sửa: đã lưu hoặc đã xóa.
enum EditorResult { saved, deleted }

/// Tạo hoặc sửa một ghi chú. [note] null nghĩa là tạo mới.
class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({
    super.key,
    required this.controller,
    this.note,
  });

  final NotesController controller;
  final Note? note;

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  late final TextEditingController _title;
  late final TextEditingController _content;
  bool _saving = false;

  bool get _isNew => widget.note == null;

  bool get _dirty {
    final originalTitle = widget.note?.title ?? '';
    final originalContent = widget.note?.content ?? '';
    return _title.text != originalTitle || _content.text != originalContent;
  }

  bool get _hasText =>
      _title.text.trim().isNotEmpty || _content.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.note?.title ?? '');
    _content = TextEditingController(text: widget.note?.content ?? '');
    _title.addListener(_refresh);
    _content.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_hasText || _saving) return;
    setState(() => _saving = true);
    try {
      final existing = widget.note;
      if (existing == null) {
        await widget.controller.create(
          title: _title.text,
          content: _content.text,
        );
      } else {
        await widget.controller.update(
          existing,
          title: _title.text,
          content: _content.text,
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop(EditorResult.saved);
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không lưu được. Thử lại.')),
      );
    }
  }

  Future<void> _delete() async {
    final note = widget.note;
    if (note == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xóa ghi chú?'),
          content: const Text('Ghi chú này sẽ mất khỏi máy.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Giữ lại'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !mounted) return;
    await widget.controller.delete(note.id);
    if (!mounted) return;
    Navigator.of(context).pop(EditorResult.deleted);
  }

  Future<void> _onBack() async {
    if (!_dirty) {
      Navigator.of(context).pop(false);
      return;
    }
    final leave = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Bỏ thay đổi?'),
          content: const Text('Nội dung chưa lưu sẽ không được giữ.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Ở lại'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Bỏ'),
            ),
          ],
        );
      },
    );
    if (leave == true && mounted) {
      Navigator.of(context).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return PopScope(
      canPop: !_dirty,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onBack();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: 'Quay lại',
            onPressed: _onBack,
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(_isNew ? 'Ghi chú mới' : 'Sửa ghi chú'),
          actions: [
            if (!_isNew)
              IconButton(
                tooltip: 'Xóa',
                onPressed: _saving ? null : _delete,
                icon: const Icon(Icons.delete_outline),
              ),
            TextButton(
              onPressed: _hasText && !_saving ? _save : null,
              child: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Lưu'),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            TextField(
              controller: _title,
              textCapitalization: TextCapitalization.sentences,
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: const InputDecoration(
                hintText: 'Tiêu đề',
                border: InputBorder.none,
              ),
            ),
            if (widget.note != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Sửa lần cuối ${formatNoteTime(widget.note!.updatedAt)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                ),
              ),
            TextField(
              controller: _content,
              autofocus: _isNew,
              minLines: 12,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Viết gì đó…',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
