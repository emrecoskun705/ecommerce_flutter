class Product {
  int id;
  String title;
  String description;
  List<dynamic> images;
  double price;
  double discountPrice; // if it is -1.0 there is no discount
  int stock;
  bool isFavourite = false;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.price,
    required this.discountPrice,
    required this.stock,
  });
}
