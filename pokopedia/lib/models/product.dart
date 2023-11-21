class Product{
  final int id;
  final int userId;
  final String name;
  final String description;
  final int stock;
  final int price;
  final int unitSold;
  final List productImages;
  final List categories;
  Product({
    required this.id, 
    required this.userId, 
    required this.name, 
    required this.description, 
    required this.stock, 
    required this.price, 
    required this.unitSold, 
    required this.productImages, 
    required this.categories,
  });
}

class ProductImage{
  final String url;
  ProductImage({
    required this.url,
  });
}
class ProductCategory{
  final String name;
  final String icon;
  final String baseColor;
  ProductCategory({
    required this.name,
    required this.icon,
    required this.baseColor,
  });
}