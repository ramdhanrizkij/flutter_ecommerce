import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../model/user_model.dart';

class AuthService {
  Future<UserModel> login({
    String email = "",
    String password = "",
  }) async {
    var url = Uri.parse(Config.authURL + '/api/login');

    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> register({
    String name = "",
    String username = "",
    String email = "",
    String password = "",
  }) async {
    var url = Uri.parse(Config.authURL + '/api/register');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      var meta = jsonDecode(response.body)['data'];
      throw Exception(meta['message']);
    }
  }

  Future<bool> update(
      {String name = "",
      String username = "",
      String email = "",
      String password = "",
      String token = ""}) async {
    var url = Uri.parse(Config.authURL + '/api/user');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      var meta = jsonDecode(response.body)['data'];
      throw Exception(meta['message']);
    }
  }
}
