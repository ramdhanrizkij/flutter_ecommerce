import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../model/user_model.dart';

class AuthService {
  Future<UserModel> login({
    String username = "",
    String password = "",
  }) async {
    var url = Uri.parse(Config.apiURL + '/auth/login');

    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'username': username,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data);
      user.token = 'Bearer ' + data['token'];

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }
}
