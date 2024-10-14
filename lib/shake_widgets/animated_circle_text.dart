import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:shake_detector_example/shake_widgets/shake_widgets.dart';

const _initialTitle = 'Shake the phone and see what I have for you!';

class AnimatedCircleText extends StatefulWidget {
  const AnimatedCircleText({
    super.key,
    required this.animation,
    required this.winLooseTexts,
  });

  final Animation animation;
  final List<String> winLooseTexts;

  @override
  State<AnimatedCircleText> createState() => _AnimatedCircleTextState();
}

class _AnimatedCircleTextState extends State<AnimatedCircleText> {
  late bool isCompleted = false;
  late String title = _initialTitle;

  @override
  void didUpdateWidget(covariant AnimatedCircleText oldWidget) {
    super.didUpdateWidget(oldWidget);

    isCompleted = widget.animation.isCompleted;
    title =
        isCompleted ? widget.winLooseTexts.getRandomElement() : _initialTitle;
  }

  @override
  Widget build(BuildContext context) {
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
              progress: widget.animation.value,
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
