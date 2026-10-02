import 'package:flutter/material.dart';

/// Ngày 12 Lab 1: stack của Navigator.
///
/// push đặt màn mới lên đỉnh. pop gỡ đúng màn đó.
/// MaterialPageRoute bọc widget thành một trang trên stack.
class HomeNavLabPage extends StatelessWidget {
  const HomeNavLabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngày 12 — Home'),
        centerTitle: true,
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const SecondNavLabPage(),
              ),
            );
          },
          child: const Text('Mở Second'),
        ),
      ),
    );
  }
}

/// Màn trên đỉnh stack. AppBar tự hiện back vì còn Home bên dưới.
class SecondNavLabPage extends StatelessWidget {
  const SecondNavLabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Pop về Home'),
            ),
            Text("Page 2"),
          ],
        ),
      ),
    );
  }
}
