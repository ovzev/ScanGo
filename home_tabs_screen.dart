// pages/home_tabs_screen.dart
import 'package:flutter/material.dart';
import 'product_list_screen.dart';
import 'offer_screen.dart';

class HomeTabsScreen extends StatefulWidget {
  @override
  _HomeTabsScreenState createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    ProductListScreen(),
    OfferScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan & Go")),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: "Offers"),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
