import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartItem.name),
      subtitle: Text('Price: \$${cartItem.price.toStringAsFixed(2)} x ${cartItem.quantity}'),
      trailing: IconButton(
        icon: Icon(Icons.remove),
        onPressed: () {
          // Remove item from cart logic here
        },
      ),
    );
  }
}
