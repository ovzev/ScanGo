import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/CartProvider.dart';
import '../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Colors.lightBlue[400],
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Your cart is empty.'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final CartItem item = cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: Icon(Icons.shopping_bag),
                    title: Text(item.name),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            cart.removeItem(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${item.name} removed from cart.')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              children: [
                Text(
                  'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to payment page or show message
                    Navigator.pushNamed(context, '/payment');
                    // Or show a temporary message:
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Proceeding to checkout...')));
                  },
                  icon: Icon(Icons.payment),
                  label: Text('Checkout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
