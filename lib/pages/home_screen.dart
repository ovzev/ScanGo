import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// استيراد الشاشات الحقيقية (تأكد أنها موجودة فعلاً في المشروع)
import 'cart_screen.dart';
import 'offer_screen.dart';
import 'profile_screen.dart';
import 'product_list_screen.dart';
import 'NewItemPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    CartScreen(),
    OfferScreen(),
    ProfileScreen(),
    ProductListScreen(),
    NewItemsPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan & Go',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue[400],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue[400]),
              child: Text(
                'Welcome!',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                _onTabTapped(3);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Settings is under development')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.lightBlue[400],
        unselectedItemColor: Colors.grey,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Offers'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: 'new item  '),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 180,
            ),
            SizedBox(height: 30),
            Text(
              'Start your smart shopping journey!',
              style: GoogleFonts.montserrat(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Sign up, shop, and pay with ease and safety.',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }
}
