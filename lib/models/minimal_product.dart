class MinimalProduct {
  final int id;
  final String title;
  final String image;
  final double price;
  final double discountPrice; // if it is -1.0 there is no discount
  bool isFavourite = false;

  MinimalProduct({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.discountPrice,
  });
}
