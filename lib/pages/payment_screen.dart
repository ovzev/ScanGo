import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Payment',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue[300],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Icon(Icons.payment, size: 100, color: Colors.lightBlue[300]),
              const SizedBox(height: 25),

              // Card Number Field
              TextFormField(
                controller: _cardNumberController,
                decoration: _inputDecoration('Card Number', Icons.credit_card),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  } else if (value.length < 16) {
                    return 'Card number must be 16 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // CVV and Expiry Date Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      decoration: _inputDecoration('CVV', Icons.lock),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter CVV';
                        } else if (value.length != 3) {
                          return 'CVV must be 3 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _expiryDateController,
                      decoration: _inputDecoration('Expiry (MM/YY)', Icons.date_range),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter expiry date';
                        } else if (!RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$').hasMatch(value)) {
                          return 'Enter valid date MM/YY';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),

              // Pay Now Button
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Payment Successful!', style: GoogleFonts.poppins())),
                    );
                    Navigator.pop(context); // Back to cart or previous screen
                  }
                },
                icon: Icon(Icons.check_circle_outline),
                label: Text('Pay Now', style: GoogleFonts.poppins(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[300],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Input decoration helper for consistent styling
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(),
      prefixIcon: Icon(icon, color: Colors.lightBlue[300]),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
