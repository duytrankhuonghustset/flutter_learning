/// Sản phẩm hardcode cho Ngày 12 Lab 2. Không fromJson, không API.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  final String id;
  final String name;
  final int price;
  final String description;
}
