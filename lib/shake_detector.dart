import 'dart:async';
import 'dart:math' as math;
import 'package:sensors_plus/sensors_plus.dart';

typedef PhoneShakeCallback = void Function();

class ShakeDetector {
  final PhoneShakeCallback onShakeStarted;
  final PhoneShakeCallback onShakeStopped;
  final double shakeThreshold;
  final int shakeIntervalMs;
  final int resetShakeCountIntervalMs;
  final int requiredShakeCount;
  final int shakeStopTimeoutMs;

  int _lastShakeTime = DateTime.now().millisecondsSinceEpoch;
  int _shakeCount = 0;
  Timer? _shakeStopTimer;

  StreamSubscription? _sensorSubscription;

  ShakeDetector({
    required this.onShakeStarted,
    required this.onShakeStopped,
    this.shakeThreshold = 2.7,
    this.shakeIntervalMs = 500,
    this.resetShakeCountIntervalMs = 3000,
    this.requiredShakeCount = 1,
    this.shakeStopTimeoutMs = 1000,
  });

  void startListening() {
    _sensorSubscription = accelerometerEventStream().listen(
      _handleAccelerometerData,
    );
  }

  void stopListening() {
    _sensorSubscription?.cancel();
    _shakeStopTimer?.cancel();
  }

  void _handleAccelerometerData(AccelerometerEvent event) {
    final gForce = _calculateGForce(event.x, event.y, event.z);

    if (gForce > shakeThreshold) {
      _processShakeEvent();
    }
  }

  double _calculateGForce(double x, double y, double z) {
    const gravity = 9.80665;
    final gX = x / gravity;
    final gY = y / gravity;
    final gZ = z / gravity;
    return math.sqrt(gX * gX + gY * gY + gZ * gZ);
  }

  void _processShakeEvent() {
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (_lastShakeTime + shakeIntervalMs > currentTime) {
      return;
    }

    if (_lastShakeTime + resetShakeCountIntervalMs < currentTime) {
      _shakeCount = 0;
    }

    _lastShakeTime = currentTime;
    _shakeCount++;

    if (_shakeCount >= requiredShakeCount) {
      onShakeStarted();
      _resetShakeStopTimer();
    }
  }

  void _resetShakeStopTimer() {
    _shakeStopTimer?.cancel();

    _shakeStopTimer = Timer(
      Duration(milliseconds: shakeStopTimeoutMs),
      () => onShakeStopped(),
    );
  }
}
