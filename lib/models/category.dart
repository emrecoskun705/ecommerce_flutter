class Category {
  final int id;
  final String name;
  final String slug;
  int? parent;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });
}
