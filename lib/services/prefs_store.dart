import 'package:shared_preferences/shared_preferences.dart';

/// Key cố định. Đổi chữ là đọc nhầm ô nhớ cũ.
const userNameKey = 'userName';
const isDarkKey = 'isDark';

/// Ngày 19: helper mỏng. Widget không gọi getInstance trực tiếp.
///
/// getInstance là Future — plugin nền tảng không trả prefs ngay trong build.
Future<SharedPreferences> _instance() => SharedPreferences.getInstance();

/// Lab 1: đọc tên. Chưa lưu thì chuỗi rỗng.
Future<String> getUserName() async {
  final prefs = await _instance();
  return prefs.getString(userNameKey) ?? '';
}

Future<void> setUserName(String name) async {
  final prefs = await _instance();
  await prefs.setString(userNameKey, name);
}

/// Lab 2: cờ dark mode. Chưa lưu thì false (sáng).
Future<bool> getIsDark() async {
  final prefs = await _instance();
  return prefs.getBool(isDarkKey) ?? false;
}

Future<void> setIsDark(bool value) async {
  final prefs = await _instance();
  await prefs.setBool(isDarkKey, value);
}
