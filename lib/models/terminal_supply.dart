class TerminalSupply {
  final int id;
  final String name;
  final String category;
  final String description;
  final int stock;
  final String? image;
  final double price;

  TerminalSupply({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.stock,
    this.image,
    required this.price,
  });

  factory TerminalSupply.fromJson(Map<String, dynamic> json) {
    return TerminalSupply(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      stock: json['stock'],
      image: json['image'],
      price: double.parse(json['price'].toString()),
    );
  }
}