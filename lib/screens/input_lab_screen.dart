import 'package:flutter/material.dart';

/// Ngày 10 Lab 1: TextField giữ chữ bằng controller; Form một ô chỉ kiểm tra không rỗng.
///
/// Form đăng nhập hai ô nằm ở LoginPage.
class InputLabScreen extends StatefulWidget {
  const InputLabScreen({super.key});

  @override
  State<InputLabScreen> createState() => _InputLabScreenState();
}

class _InputLabScreenState extends State<InputLabScreen> {
  late final TextEditingController _textController;
  final _formKey = GlobalKey<FormState>();

  /// Chữ đọc từ controller khi bấm "In chữ". Không phải state của từng phím.
  String _shown = '';

  /// null = chưa bấm Kiểm tra.
  String? _formStatus;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    debugPrint('[InputLab] initState — tạo TextEditingController');
  }

  @override
  void dispose() {
    debugPrint('[InputLab] dispose — hủy TextEditingController');
    _textController.dispose();
    super.dispose();
  }

  void _printText() {
    setState(() => _shown = _textController.text);
  }

  void _clearText() {
    _textController.clear();
    setState(() => _shown = '');
  }

  void _checkForm() {
    final ok = _formKey.currentState!.validate();
    setState(() {
      _formStatus = ok
          ? 'Hợp lệ — validator trả null.'
          : 'Chưa hợp lệ — validator trả câu lỗi.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Lab — Ngày 10'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Back khỏi màn này → dispose controller. '
            'setState (In chữ / Xóa) không tạo controller mới.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          _Card(
            title: '1) TextField + controller',
            explanation:
                'Controller giữ chữ. "In chữ" đọc controller.text một lần. '
                '"Xóa" gọi clear() — ô trống vì TextField đang nghe controller đó.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Nhập gì đó',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: _printText,
                        child: const Text('In chữ'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.tonal(
                        onPressed: _clearText,
                        child: const Text('Xóa'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _shown.isEmpty ? 'Chưa in.' : 'Đã in: $_shown',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _Card(
            title: '2) Form — một ô, không được rỗng',
            explanation:
                'Kiểm tra gọi formKey.currentState.validate(). '
                'validator trả null là hợp lệ; trả một chuỗi thì chuỗi đó hiện dưới ô.',
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Tên',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Không được để trống';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _checkForm,
                    child: const Text('Kiểm tra'),
                  ),
                  if (_formStatus != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _formStatus!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              explanation,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
