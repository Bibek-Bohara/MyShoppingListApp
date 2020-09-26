
import 'dart:convert';

import 'package:MyShoppingList/feature/cart/model/cart.dart';

class Order {
  Order({
    this.id,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.delivered,
    this.address,
    this.city,
    this.chargeId,
    this.cart,
  });

  final int id;
  final double amount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool delivered;
  final String address;
  final String city;
  final String chargeId;
  final List<Cart> cart;

  Order copyWith({
    int id,
    double amount,
    DateTime createdAt,
    DateTime updatedAt,
    bool delivered,
    String address,
    String city,
    String chargeId,
    List<Cart> cart,
  }) =>
      Order(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        delivered: delivered ?? this.delivered,
        address: address ?? this.address,
        city: city ?? this.city,
        chargeId: chargeId ?? this.chargeId,
        cart: cart ?? this.cart,
      );

  factory Order.fromJson(Map<String, dynamic> json) =>
      Order(
        id: json["id"],
        amount: json["amount"].toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        delivered: json["delivered"],
        address: json["Address"],
        city: json["City"],
        chargeId: json["charge_id"],
        cart: json["product"] != null ? (json["product"] as List).map((e) =>
            Cart.fromJson(e as Map<String, dynamic>))?.toList() : null,
      );
}
