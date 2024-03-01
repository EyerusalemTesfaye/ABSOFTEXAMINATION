import 'dart:convert';

import 'package:absoftexamination/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _userKey = 'user';
  static final String tokenKey = 'token';
  static const String _isFirstTimeKey = 'is_first_time';

  static Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> userMap = {
      'id': user.id,
      'email': user.email,
      'role': user.role,
      'fullname': user.fullname,
      'age': user.age,
      'grade': user.grade,
      'token': user.token,
    };
    prefs.setString(_userKey, jsonEncode(userMap));
  }

  static Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString(_userKey);
    if (userString != null) {
      final Map<String, dynamic> userMap = jsonDecode(userString);
      return User(
        id: userMap['id'],
        email: userMap['email'],
        role: userMap['role'],
        fullname: userMap['fullname'],
        age: userMap['age'],
        grade: userMap['grade'],
        token: userMap['token'],
      );
    }
    return null;
  }

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenKey, token);
    print('tokenKey${token}');
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }

  static Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_userKey);
    print('fgggfgfffffff${_userKey}');
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  static Future<void> setFirstTime(bool isFirstTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isFirstTimeKey, isFirstTime);
  }

  static Future<bool> isFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstTimeKey) ?? true;
  }
}
