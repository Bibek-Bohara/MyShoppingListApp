import 'package:MyShoppingList/common/model/picture.dart';
import 'package:MyShoppingList/feature/home/model1/category.dart';

class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.isFeatured,
    this.brand,
    this.color,
    this.picture,
  });

  final int id;
  final String name;
  final String description;
  final double price;
  final Category category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFeatured;
  final Category brand;
  final dynamic color;
  final Picture picture;

  Product copyWith({
    int id,
    String name,
    String description,
    double price,
    Category category,
    DateTime createdAt,
    DateTime updatedAt,
    bool isFeatured,
    Category brand,
    dynamic color,
    Picture picture,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        category: category ?? this.category,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isFeatured: isFeatured ?? this.isFeatured,
        brand: brand ?? this.brand,
        color: color ?? this.color,
        picture: picture ?? this.picture,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"].toDouble(),
    category: json["category"] == null ? Category(
        id: 0,name: 'Others',description: '',createdBy: 0,updatedBy: 0, createdAt: DateTime.now(),updatedAt: DateTime.now()
    ) : Category.fromJson(json["category"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isFeatured: json["isFeatured"] == null ? null : json["isFeatured"],
    brand: json["brand"] == null ? null : Category.fromJson(json["brand"]),
    color: json["color"],
    picture: json['picture'] == null ? null : Picture.fromJson(json["picture"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "category": category.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "isFeatured": isFeatured == null ? null : isFeatured,
    "brand": brand == null ? null : brand.toJson(),
    "color": color,
    "picture": picture.toJson(),
  };
}