import 'package:ecommerce_faza/model/product_model.dart';

class CartModel {
  int? id;
  ProductModel? product;
  int? quantity;

  CartModel({
    this.id,
    this.product,
    this.quantity,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product?.toJson(),
      'quantity': quantity,
    };
  }

  int getTotalPrice() {
    if (product?.price != null && quantity != null) {
      return product!.price! * quantity!;
    } else {
      return 0;
    }
  }
}
