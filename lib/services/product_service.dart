import 'dart:convert';
import 'package:ecommerce_faza/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class ProductService {
  Future<List<ProductModel>> getProducts() async {
    var url = Uri.parse(Config.apiURL + '/products');

    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(
      url,
      headers: headers,
    );

    // print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['products'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Gagal Login');
    }
  }
}
