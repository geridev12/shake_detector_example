import 'package:flutter/material.dart';
import 'package:shake_detector_example/pages/shake_detector_page.dart';

class ShakeDetectorExample extends StatelessWidget {
  const ShakeDetectorExample({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
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
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        home: const ShakeDetectorPage(),
      );
}
