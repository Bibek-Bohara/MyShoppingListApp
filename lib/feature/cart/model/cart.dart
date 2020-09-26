import 'package:MyShoppingList/common/model/picture.dart';
import 'package:MyShoppingList/feature/profile/model/profile.dart';

class Cart {
  Cart({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.count,
  });

  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CartProduct product;
  final int count;

  Cart copyWith({
    int id,
    DateTime createdAt,
    DateTime updatedAt,
    CartProduct product,
    int count,
  }) =>
      Cart(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        product: product ?? this.product,
        count: count ?? this.count,
      );

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    product: CartProduct.fromJson(json["product"]),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product": product.toJson(),
    "count": count,
  };
}

class CartProduct {
  CartProduct({
    this.id,
    this.name,
    this.description,
    this.price,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.isFeatured,
    this.color,
    this.picture,
  });

  final int id;
  final String name;
  final String description;
  final double price;
  final int category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFeatured;
  final String color;
  final Picture picture;

  CartProduct copyWith({
    int id,
    String name,
    String description,
    double price,
    int category,
    DateTime createdAt,
    DateTime updatedAt,
    bool isFeatured,
    String color,
    Picture picture,
  }) =>
      CartProduct(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        category: category ?? this.category,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isFeatured: isFeatured ?? this.isFeatured,
        color: color ?? this.color,
        picture: picture ?? this.picture,
      );

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"].toDouble(),
    category: json["category"] != null ? json["category"].toInt(): 0,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isFeatured: json["isFeatured"] == null ? null : json["isFeatured"],
    color: json["color"],
    picture: json["picture"] != null ? Picture.fromJson(json["picture"]): null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "category": category,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "isFeatured": isFeatured == null ? null : isFeatured,
    "color": color,
    "picture": picture.toJson(),
  };
}