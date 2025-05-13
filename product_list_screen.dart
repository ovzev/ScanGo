// pages/product_list_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Apple', 'price': 2.5, 'image': 'assets/images/apple.jpg'},
    {'name': 'Banana', 'price': 1.2, 'image': 'assets/images/banana.jpg'},
    {'name': 'Milk', 'price': 3.0, 'image': 'assets/images/milk.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Products", style: GoogleFonts.poppins()),
          bottom: TabBar(tabs: [
            Tab(text: "Grid View"),
            Tab(text: "List View"),
          ]),
        ),
        body: TabBarView(children: [
          GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(products[index]['name'], style: TextStyle(fontSize: 20)),
                              SizedBox(height: 8),
                              Text('Price: \$${products[index]['price']}'),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Center(child: Text(products[index]['name'])),
                ),
              );
            },
          ),
          ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(products[index]['name']),
                subtitle: Text('\$${products[index]['price']}'),
              );
            },
          )
        ]),
      ),
    );
  }
}
