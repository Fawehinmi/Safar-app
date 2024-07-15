import 'package:flutter/material.dart';
import 'permissions_page.dart';
import 'home_page.dart';
import 'device_page.dart';
import 'splash_screen.dart';
import 'audio_settings.dart';
import 'dua_control.dart';
import 'azkar_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Permission App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
       routes: {
        '/home': (context) => HomePage(),
        '/device': (context) => DevicePage(),
        '/settings': (context) => AudioSettingsPage(),
        '/dua': (context) => DuaControlPage(),
        '/azkar': (context) => AzkarPage(),
      },
    );
  }
}
