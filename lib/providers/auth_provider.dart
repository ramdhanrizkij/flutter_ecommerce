import 'package:ecommerce_faza/model/user_model.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user = new UserModel();
  UserModel get user => _user;
  String errorMessage = "";
  bool isAuthenticated = false;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> update({
    String name = "",
    String username = "",
    String email = "",
  }) async {
    try {
      bool updated = await AuthService().update(
          name: name, username: username, email: email, token: _user.token!);

      _user.name = name;
      _user.username = username;
      _user.email = email;

      isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    String name = "",
    String username = "",
    String email = "",
    String password = "",
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );

      _user = user;
      isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> login({
    String email = "",
    String password = "",
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;
      isAuthenticated = true;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
