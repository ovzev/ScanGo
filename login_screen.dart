import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // For storing form state
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Validate email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Check if email is valid
    RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  // Validate password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Login function
  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text;
      String password = _passwordController.text;

      // Simulating login (replace this with actual API logic)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful')),
      );

      // After successful login, navigate to Product List Screen
      Navigator.pushReplacementNamed(context, '/products'); // Go to Product List
    } else {
      // Handle invalid login if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid login credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Login',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue[400], // Matching Home Screen color
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue[400]!),
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.lightBlue[400]),
                ),
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue[400]!),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.lightBlue[400]),
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 24),

              // Login Button
              ElevatedButton(
                onPressed: _login, // Trigger the login function
                child: Text('Login', style: GoogleFonts.poppins(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[400],
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Registration Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account? ', style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register'); // Navigate to Register screen
                    },
                    child: Text(
                      'Sign up now',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.lightBlue[400], // Matching Home Screen color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
