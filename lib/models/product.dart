class Partner {
  final int id;
  final String name;

  Partner({
    required this.id,
    required this.name,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final double rentPrice;
  final int stock;
  final int maxRentDay;
  final String storage;
  final String color;
  final String imageUrl;
  final Partner partner;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.rentPrice,
    required this.stock,
    required this.maxRentDay,
    required this.storage,
    required this.color,
    required this.imageUrl,
    required this.partner,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      rentPrice: double.tryParse(json['rent_price'].toString()) ?? 0.0,
      stock: json['stock'],
      maxRentDay: json['max_rent_day'],
      storage: json['storage'],
      color: json['color'],
      imageUrl: json['image_url'],
      partner: Partner.fromJson(json['partner']),
    );
  }
}