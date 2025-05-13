// pages/login_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // Navigate after login
        Navigator.pushReplacementNamed(context, '/');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(controller: emailController, decoration: InputDecoration(labelText: "Email"), validator: (value) => value!.isEmpty ? "Enter Email" : null),
              TextFormField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: "Password"), validator: (value) => value!.isEmpty ? "Enter Password" : null),
              ElevatedButton(onPressed: _login, child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}
