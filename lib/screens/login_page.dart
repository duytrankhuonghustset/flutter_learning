import 'package:flutter/material.dart';

/// Ngày 10 Lab 2: Form hai ô. Validator chỉ kiểm tra định dạng.
///
/// Sai tài khoản hiện riêng, không nhét vào validator. Không gọi API.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _validEmail = 'hoc@flutter.dev';
  static const _validPassword = '123456';

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool _obscurePassword = true;

  /// null = chưa so tài khoản. Khác lỗi validator (hiện dưới từng ô).
  String? _accountMessage;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    debugPrint('[LoginPage] initState — tạo 2 controller');
  }

  @override
  void dispose() {
    debugPrint('[LoginPage] dispose — hủy 2 controller');
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final formOk = _formKey.currentState!.validate();
    if (!formOk) {
      setState(() => _accountMessage = null);
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final matched = email == _validEmail && password == _validPassword;

    setState(() {
      _accountMessage = matched
          ? 'Đăng nhập đúng.'
          : 'Sai tài khoản hoặc mật khẩu.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final accountColor = _accountMessage == 'Đăng nhập đúng.'
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.error;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập — Ngày 10'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Validator: email đúng dạng, mật khẩu không rỗng. '
            'Đúng dạng rồi mới so với hoc@flutter.dev / 123456. '
            'Sai tài khoản không phải lỗi validator.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (email.isEmpty) {
                      return 'Nhập email';
                    }
                    final looksLikeEmail = RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    ).hasMatch(email);
                    if (!looksLikeEmail) {
                      return 'Email không đúng định dạng';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nhập mật khẩu';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _submit,
                  child: const Text('Đăng nhập'),
                ),
                if (_accountMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _accountMessage!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: accountColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
