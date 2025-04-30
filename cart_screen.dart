import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom fonts
import '../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(name: 'Apple', price: 2.5, quantity: 1),
    CartItem(name: 'Banana', price: 1.2, quantity: 2),
  ];

  double get totalPrice {
    return cartItems.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item removed from cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold), // Custom font for the title
        ),
        backgroundColor: Colors.lightBlue[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the Product List screen
          },
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          'Your cart is empty!',
          style: GoogleFonts.roboto(fontSize: 20, color: Colors.grey[700]), // Custom font for empty cart message
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(12.0),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal[300],
                child: Icon(Icons.shopping_cart, color: Colors.white),
              ),
              title: Text(
                item.name,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18), // Custom font for item name
              ),
              subtitle: Text(
                'Price: \$${item.price} | Quantity: ${item.quantity}',
                style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600]), // Custom font for price & quantity
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => removeItem(index),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue[400],
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Total: \$${totalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/payment'); // Navigate to the payment screen
                },
                icon: Icon(Icons.payment),
                label: Text(
                  'Checkout',
                  style: GoogleFonts.lato(fontSize: 16), // Custom font for checkout button
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[300],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
