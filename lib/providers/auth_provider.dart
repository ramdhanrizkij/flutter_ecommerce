import 'package:ecommerce_faza/model/user_model.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user = new UserModel();

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  // Future<bool> register({
  //   String username,
  //   String email,
  //   String password,
  // }) async {
  //   try {
  //     UserModel user = await AuthService().register(
  //       name: name,
  //       username: username,
  //       email: email,
  //       password: password,
  //     );

  //     _user = user;
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  Future<bool> login({
    String username = "",
    String password = "",
  }) async {
    try {
      UserModel user = await AuthService().login(
        username: username,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
