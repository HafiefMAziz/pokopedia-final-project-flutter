class ProductModel {
  String id;
  String name;
  String price;

  ProductModel({required this.id, required this.name, required this.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"].toString(),
      name: json["name"],
      price: json["price"],
    );
  }
}
