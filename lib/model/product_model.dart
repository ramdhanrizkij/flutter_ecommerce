class ProductModel {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  String? brand;
  String? category;
  String? thumbnail;

  ProductModel(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.brand,
      this.category,
      this.thumbnail});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = int.parse(json['price'].toString());
    rating = double.parse(json['rating'].toString());
    // price = double.parse(json['price']);
    // discountPercentage = double.parse(json['discountPercentage']);
    // rating = double.parse(json['rating']);
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'brand': brand,
      'category': category,
      'thumbnail': thumbnail,
    };
  }
}
