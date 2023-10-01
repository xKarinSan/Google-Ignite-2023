export "helper_functions.dart";

class Countdown {
  final DateTime timestamp;

  int? daysRemaining;
  int? hoursRemaining;
  int? minutesRemaining;
  int? secondsRemaining;

  Countdown(this.timestamp) {
    calculateRemainingTime();
  }

  void calculateRemainingTime() {
    final now = DateTime.now();
    final delta = timestamp.difference(now);

    if (delta.inSeconds < 0) {
      daysRemaining = 0;
      hoursRemaining = 0;
      minutesRemaining = 0;
      secondsRemaining = 0;
    } else {
      daysRemaining = delta.inDays;
      hoursRemaining = delta.inHours % 24;
      minutesRemaining = delta.inMinutes % 60;
      secondsRemaining = delta.inSeconds % 60;
    }
  }

  String get formattedRemainingTime {
    return '${daysRemaining}d, ${hoursRemaining}h, ${minutesRemaining}min, ${secondsRemaining}s';
  }
}
