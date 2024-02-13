import 'package:absoftexamination/model/user.dart';
import 'package:absoftexamination/util/shared_preferences_util.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  // String? _token;

  // User? get user => _user;
  // String? get token => _token;

  UserProvider() {
    _loadUser();
  }
  Map<String, dynamic>? _userData;
  String? _token;

  Map<String, dynamic>? get userData => _userData;
  String? get token => _token;

  void setUserData(Map<String, dynamic> data) {
    _userData = data;
    print(_userData);
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    print('token isnnnnnnnnn: ${_token}');
    notifyListeners();
  }

  Future<void> _loadUser() async {
    _user = await UserPreferences.getUser();
    _token = await UserPreferences.getToken();
    notifyListeners();
  }

  Future<void> loginUser(User user, String token) async {
    _user = user;
    _token = token;
    await UserPreferences.saveUser(user);
    await UserPreferences.saveToken(token);
    notifyListeners();
  }

  Future<void> logoutUser() async {
    _user = null;
    _token = null;
    await UserPreferences.removeToken();
    notifyListeners();
  }
}
