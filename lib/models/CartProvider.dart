import 'package:flutter/material.dart';
import 'cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem product) {
    final index = _items.indexWhere((item) => item.name == product.name);
    if (index != -1) {
      _items[index].quantity += 1;
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

void removeItem(CartItem item) {
  _items.remove(item);
  notifyListeners();
}}