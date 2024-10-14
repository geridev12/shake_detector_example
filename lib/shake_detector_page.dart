import 'package:flutter/material.dart';
import 'package:shake_detector_example/shake_detector.dart';
import 'package:shake_detector_example/shake_widgets/shake_widgets.dart';

class ShakeDetectorPage extends StatefulWidget {
  const ShakeDetectorPage({super.key});

  @override
  State<ShakeDetectorPage> createState() => _ShakeDetectorPageState();
}

class _ShakeDetectorPageState extends State<ShakeDetectorPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _animation;
  late final ShakeDetector _detector;
  late final List<String> _winLooseTexts;

  @override
  void initState() {
    super.initState();

    _winLooseTexts = <String>[
      'Try again!',
      'Congratulations! You won 10 MB of data!',
    ];

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      _animationController,
    );

    _detector = ShakeDetector(
      onShakeStarted: () async => _onStartShaking(),
      onShakeStopped: () async => _onStopShaking(),
    );

    _detector.startListening();
  }

  Future<void> _onStartShaking() async => _animationController.forward();

  Future<void> _onStopShaking() async {
    if (!_animation.isCompleted) {
      await _animationController.reverse();
    } else {
      Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () => _animationController.reset(),
      );
    }
  }

  @override
  void dispose() {
    _detector.startListening();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shake App'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) => AnimatedCircleText(
            animation: _animation,
            winLooseTexts: _winLooseTexts,
          ),
        ),
      ),
    );
  }
}
