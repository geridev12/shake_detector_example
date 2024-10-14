import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:shake_detector_example/shake_widgets/shake_widgets.dart';

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
        : 'Shake the phone and see what I have for you!';

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
            child: AnimationProgressStatus(
              isCompleted: isCompleted,
              isCompletedWidet: const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 200,
                ),
              ),
              isNotCompletedWidget: Image.asset(
                'assets/phone_shake.png',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimationProgressStatus extends StatelessWidget {
  const AnimationProgressStatus({
    super.key,
    required this.isCompleted,
    required this.isCompletedWidet,
    required this.isNotCompletedWidget,
  });

  final bool isCompleted;
  final Widget isCompletedWidet;
  final Widget isNotCompletedWidget;

  @override
  Widget build(BuildContext context) {
    return isCompleted ? isCompletedWidet : isNotCompletedWidget;
  }
}

extension IterableX<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}
