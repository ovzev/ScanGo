import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final double price;
  final String? image;
  final Color? color; // اللون (اختياري)
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    this.image,
    this.color, // يمكن أن يكون null
    this.quantity = 1,
  });
}
