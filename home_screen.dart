// pages/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/background.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to Scan & Go", style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () { Navigator.pushNamed(context, '/login'); },
                icon: Icon(Icons.arrow_forward),
                label: Text("Get Started"),
              )
            ],
          )
        ],
      ),
    );
  }
}
