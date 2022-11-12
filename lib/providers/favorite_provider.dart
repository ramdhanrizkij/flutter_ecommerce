import 'package:ecommerce_faza/model/product_model.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  List<ProductModel> favorite = [];

  setProduct(ProductModel product) {
    if (!isWishlist(product)) {
      favorite.add(product);
    } else {
      favorite.removeWhere((element) => element.id == product.id);
    }
    notifyListeners();
  }

  isWishlist(ProductModel product) {
    if (favorite.indexWhere((element) => element.id == product.id) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
