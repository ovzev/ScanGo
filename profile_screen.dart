import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart'; // لتحفظ البيانات

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bioController = TextEditingController();
  DateTime? _selectedDate;
  double _sliderValue = 50;
  bool _newsletterSubscribed = false;
  String _selectedGender = 'Male';
  File? _selectedImage;

  // لحفظ البيانات في SharedPreferences
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _bioController.text = prefs.getString('bio') ?? '';
      _sliderValue = prefs.getDouble('satisfaction') ?? 50;
      _newsletterSubscribed = prefs.getBool('newsletter') ?? false;
      _selectedGender = prefs.getString('gender') ?? 'Male';
      String? imagePath = prefs.getString('image');
      if (imagePath != null) {
        _selectedImage = File(imagePath);
      }
    });
  }

  // لحفظ البيانات في SharedPreferences
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bio', _bioController.text);
    await prefs.setDouble('satisfaction', _sliderValue);
    await prefs.setBool('newsletter', _newsletterSubscribed);
    await prefs.setString('gender', _selectedGender);
    if (_selectedImage != null) {
      await prefs.setString('image', _selectedImage!.path);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // لتحميل البيانات المخزنة
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _saveData(); // حفظ البيانات عند التقديم
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile Submitted Successfully')),
      );
      Navigator.pushReplacementNamed(context, '/'); // Go to Product List
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlue[300],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            // هنا نقوم بعرض البيانات في المستطيل الجانبي
            ListTile(
              title: Text('Profile'),
              subtitle: Text('Gender: $_selectedGender\nBio: ${_bioController.text}'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings or any other screen
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                  child: _selectedImage == null ? Icon(Icons.add_a_photo, size: 40, color: Colors.white70) : null,
                  backgroundColor: Colors.lightBlue[100],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _bioController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Your Bio',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your bio' : null,
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                title: Text('Subscribe to Newsletter'),
                value: _newsletterSubscribed,
                onChanged: (val) {
                  setState(() {
                    _newsletterSubscribed = val!;
                  });
                },
              ),
              Column(
                children: [
                  ListTile(
                    title: Text('Male'),
                    leading: Radio(
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Female'),
                    leading: Radio(
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Satisfaction Level: ${_sliderValue.round()}%'),
                  Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: _sliderValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Select Birth Date'
                        : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  ),
                  TextButton(
                    onPressed: _pickDate,
                    child: Text('Pick Date'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: Icon(Icons.save),
                label: Text('Save Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[300],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
