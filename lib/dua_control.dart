import 'package:flutter/material.dart';

class DuaControlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 50), // Top padding
              // Back Button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Navigator.pop(context);
                  },
                ),
              ),
              // Logo
              Image.asset(
                'assets/logo.jpg', // Replace with your logo asset
                height: 100,
              ),
              SizedBox(height: 10),
              // Dua Control Title
              Text(
                'Dua Control:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(thickness: 1, height: 40, color: Colors.black),
              // Bismillah Button
              Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFB0C5FB)),
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFB0C5FB).withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.play_arrow, color: Colors.black),
                  label: Text('Bismillah'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    shadowColor: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Instruction Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'After your first time pressing Bismillah, your car will automatically play the Safar Dua without having to open the app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Morning/Night Azkar Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Icon(Icons.wb_sunny, size: 40),
                      Icon(Icons.nights_stay, size: 40),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        activeColor: Colors.blue,
                      ),
                      Text('Morning/Night Azkar'),
                    ],
                  ),
                  SizedBox(width: 30),
                  // Audio Settings Icon
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.volume_up, size: 40),
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => AudioSettingsPage()));
                        },
                      ),
                      Text('Audio settings'),
                    ],
                  ),
                ],
              ),
              Spacer(),
              // Footer Link
              GestureDetector(
                onTap: () {
                  // Handle Azkar info tap
                },
                child: Text(
                  'What is Azkar?',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Icon(Icons.info_outline, size: 16),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
