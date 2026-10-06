import 'package:flutter/foundation.dart';

/// Ngày 23 Lab 1: số đếm sống ngoài State của màn.
class CounterNotifier extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    // Không gọi thì widget đang watch không dựng lại.
    notifyListeners();
  }
}
