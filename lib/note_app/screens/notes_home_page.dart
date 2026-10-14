import 'package:flutter/material.dart';

import 'package:flutter_learning/note_app/models/note.dart';
import 'package:flutter_learning/note_app/screens/note_editor_page.dart';
import 'package:flutter_learning/note_app/services/note_store.dart';
import 'package:flutter_learning/note_app/state/notes_controller.dart';

/// Màn vào từ Profile: tự tạo controller và đọc ghi chú đã lưu.
class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late final NotesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NotesController(NoteStore());
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotesHomePage(controller: _controller);
  }
}

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key, required this.controller});

  final NotesController controller;

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onNotes);
    _search.addListener(_onSearch);
  }

  void _onNotes() {
    if (mounted) setState(() {});
  }

  void _onSearch() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onNotes);
    _search.dispose();
    super.dispose();
  }

  Future<void> _openEditor({Note? note}) async {
    final result = await Navigator.of(context).push<EditorResult>(
      MaterialPageRoute(
        builder: (context) => NoteEditorPage(
          controller: widget.controller,
          note: note,
        ),
      ),
    );
    if (!mounted || result == null) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    final message = switch (result) {
      EditorResult.saved => note == null ? 'Đã lưu ghi chú mới.' : 'Đã cập nhật.',
      EditorResult.deleted => 'Đã xóa ghi chú.',
    };
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }

  Future<bool> _askDelete(Note note) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xóa ghi chú?'),
          content: Text(
            note.title.trim().isEmpty
                ? 'Ghi chú này sẽ mất khỏi máy.'
                : '“${note.title.trim()}” sẽ mất khỏi máy.',
          ),
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
    return confirmed == true;
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final query = _search.text;
    final visible = filterNotes(controller.notes, query);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghi chú'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(),
        icon: const Icon(Icons.add),
        label: const Text('Ghi chú mới'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: SearchBar(
              controller: _search,
              hintText: 'Tìm theo tiêu đề hoặc nội dung',
              leading: const Icon(Icons.search),
              trailing: [
                if (query.isNotEmpty)
                  IconButton(
                    tooltip: 'Xóa từ khóa',
                    onPressed: _search.clear,
                    icon: const Icon(Icons.close),
                  ),
              ],
            ),
          ),
          Expanded(child: _buildBody(controller, visible, query)),
        ],
      ),
    );
  }

  Widget _buildBody(NotesController controller, List<Note> visible, String query) {
    if (controller.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.error != null && controller.notes.isEmpty) {
      return _EmptyView(
        icon: Icons.error_outline,
        title: controller.error!,
        actionLabel: 'Thử lại',
        onAction: controller.load,
      );
    }
    if (controller.notes.isEmpty) {
      return _EmptyView(
        icon: Icons.note_alt_outlined,
        title: 'Chưa có ghi chú',
        subtitle: 'Bấm “Ghi chú mới” để viết ghi chú đầu tiên. Dữ liệu nằm trên máy này.',
        actionLabel: 'Tạo ghi chú',
        onAction: () => _openEditor(),
      );
    }
    if (visible.isEmpty) {
      return _EmptyView(
        icon: Icons.search_off,
        title: 'Không thấy “${query.trim()}”',
        subtitle: 'Thử từ khác, hoặc xóa bộ lọc để xem hết danh sách.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      itemCount: visible.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final note = visible[index];
        return Dismissible(
          key: ValueKey(note.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.delete_outline,
              color: Theme.of(context).colorScheme.onError,
            ),
          ),
          confirmDismiss: (direction) => _askDelete(note),
          onDismissed: (direction) {
            widget.controller.delete(note.id);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đã xóa ghi chú.')),
            );
          },
          child: _NoteCard(
            note: note,
            onTap: () => _openEditor(note: note),
          ),
        );
      },
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note, required this.onTap});

  final Note note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final title = note.title.trim().isEmpty ? 'Không tiêu đề' : note.title.trim();
    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                note.preview,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                formatNoteTime(note.updatedAt),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: scheme.outline,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: scheme.primary),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 20),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
