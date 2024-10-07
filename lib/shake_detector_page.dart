import 'package:flutter/material.dart';

class ShakeDetectorPage extends StatefulWidget {
  const ShakeDetectorPage({super.key});

  @override
  State<ShakeDetectorPage> createState() => _ShakeDetectorPageState();
}

class _ShakeDetectorPageState extends State<ShakeDetectorPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Shake App'),
      ),
    );
  }
}
