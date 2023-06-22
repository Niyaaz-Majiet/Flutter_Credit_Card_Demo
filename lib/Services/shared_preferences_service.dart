import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

const String BANNED = 'banned';
const String CARDS = 'cards';

class SharedPref {
  static Future<bool> setItem(path, data) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      await prefs.setString(path, data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeItem(path) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      await prefs.remove(path);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future getItem(path) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var data = prefs.getString(path) ?? '';
      return data;
    } catch (e) {
      return '';
    }
  }
}
