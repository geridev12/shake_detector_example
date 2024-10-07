import 'package:flutter/material.dart';
import 'package:shake_detector_example/shake_detector_page.dart';

void main() => runApp(
      const ShakeDetectorExample(),
    );

class ShakeDetectorExample extends StatelessWidget {
  const ShakeDetectorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shake Detector',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(
          0xff2a2a2a,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(
            0xff2a2a2a,
          ),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      home: const ShakeDetectorPage(),
    );
  }
}
