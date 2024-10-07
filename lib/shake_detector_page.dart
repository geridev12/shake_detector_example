import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:shake_detector_example/shake_detector.dart';

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
      'Provojeni përsëri!',
      'Urime! Ju fituar 100 MB!',
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
      onShakeStopped: () => _onStopShaking(),
    );

    _detector.startListening();
  }

  Future<void> _onStartShaking() async => _animationController.forward();

  void _onStopShaking() {
    if (!_animation.isCompleted) {
      _animationController.reverse();
    } else {
      Future.delayed(
        const Duration(
          seconds: 1,
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

class AnimatedCircleText extends StatelessWidget {
  const AnimatedCircleText({
    super.key,
    required this.animation,
    required this.winLooseTexts,
  });

  final Animation animation;
  final List<String> winLooseTexts;

  @override
  Widget build(BuildContext context) {
    final isCompleted = animation.isCompleted;
    final title = isCompleted
        ? winLooseTexts.getRandomElement()
        : 'Tunde telefonin dhe shiko se çfarë kam për ty!';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 100),
          CustomPaint(
            painter: CustomCirclePainter(
              progress: animation.value,
              isCompleted: isCompleted,
            ),
            child: isCompleted
                ? const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.black,
                      size: 200,
                    ),
                  )
                : Image.asset(
                    'assets/phone_shake.png',
                    color: Colors.white,
                  ),
          ),
        ],
      ),
    );
  }
}

class CustomCirclePainter extends CustomPainter {
  const CustomCirclePainter({
    required this.progress,
    required this.isCompleted,
  });

  final double progress;
  final bool isCompleted;

  @override
  void paint(Canvas canvas, Size size) {
    const circleRadius = 150.0;

    final backgroundRingPaintColor =
        isCompleted ? Colors.white : Colors.transparent;

    final backgroundRingPaint = Paint()
      ..color = backgroundRingPaintColor
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final center = Offset(centerX, centerY);

    canvas.drawCircle(
      center,
      circleRadius,
      backgroundRingPaint,
    );

    final progressPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: circleRadius,
      ),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomCirclePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

extension IterableX<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}
