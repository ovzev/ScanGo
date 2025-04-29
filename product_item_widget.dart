import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;

  ProductItemWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          // Add product to cart logic here
        },
      ),
    );
  }
}
