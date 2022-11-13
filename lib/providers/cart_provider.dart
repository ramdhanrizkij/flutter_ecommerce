import 'package:flutter/material.dart';

import '../model/cart_model.dart';
import '../model/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> carts = [];

  addCart(ProductModel product) {
    if (productExist(product)) {
      int index =
          carts.indexWhere((element) => element.product?.id == product.id);
      if (carts[index]!.quantity != null) {
        carts[index].quantity = carts[index].quantity! + 1;
      }
    } else {
      carts.add(
        CartModel(
          id: carts.length,
          product: product,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  removeCart(int id) {
    carts.removeAt(id);
    notifyListeners();
  }

  removeAll() {
    carts.clear();
    notifyListeners();
  }

  addQuantity(int id) {
    if (carts[id]!.quantity != null) {
      carts[id].quantity = carts[id].quantity! + 1;
    }
    notifyListeners();
  }

  reduceQuantity(int id) {
    if (carts[id]!.quantity != null) {
      carts[id].quantity = carts[id].quantity! - 1;
    }
    if (carts[id].quantity == 0) {
      carts.removeAt(id);
    }
    notifyListeners();
  }

  totalItems() {
    int total = 0;
    for (var item in carts) {
      total += item.quantity!;
    }
    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in carts) {
      var qty = item.quantity ?? 0;
      var price = item.product!.price ?? 0;
      total += qty * price;
    }
    return total;
  }

  productExist(ProductModel product) {
    if (carts.indexWhere((element) => element.product!.id == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }
}
