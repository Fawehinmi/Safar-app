import 'package:flutter/material.dart';


class AudioSettingsPage extends StatefulWidget {
  @override
  _AudioSettingsPageState createState() => _AudioSettingsPageState();
}

class _AudioSettingsPageState extends State<AudioSettingsPage> {
  double _currentVolume = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Settings'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Audio Settings Title
              Text(
                'Audio Settings:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Volume Selection Subtitle
              Text(
                'Choose the volume you want when you start your car:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              // Volume Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.volume_down),
                  Expanded(
                    child: Slider(
                      value: _currentVolume,
                      onChanged: (value) {
                        setState(() {
                          _currentVolume = value;
                        });
                      },
                      min: 0,
                      max: 1,
                      divisions: 10,
                      activeColor: Colors.orange,
                      inactiveColor: Colors.grey,
                    ),
                  ),
                  Icon(Icons.volume_up),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
