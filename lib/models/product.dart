/// Sản phẩm. Ngày 12 dùng constructor. Ngày 15 thêm toJson / fromJson.
///
/// Không gọi API ở đây. Model chỉ đổi dạng dữ liệu.
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

  /// Ngày 15 Lab 1: object → Map. Key này phải khớp fromJson.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }

  /// Ngày 15 Lab 2: một Map → một Product.
  ///
  /// `as String` / `as int` đúng vì map hardcode đúng kiểu.
  /// JSON số từ mạng đôi khi là `num` — Ngày 17 mới xử lý thêm.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
    );
  }

  /// Ngày 15 Lab 2: list map → list Product.
  ///
  /// `jsonDecode` của một mảng trả `List<dynamic>`. Khi đó cast từng phần tử:
  /// `Product.fromJson(item as Map<String, dynamic>)`.
  static List<Product> listFromJson(List<Map<String, dynamic>> raw) {
    return raw.map(Product.fromJson).toList();
  }
}
