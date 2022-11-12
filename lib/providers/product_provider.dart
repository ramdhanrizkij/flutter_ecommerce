import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> products = [];

  Future<void> getProducts() async {
    try {
      products = await ProductService().getProducts();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
