import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:restaurant_app/utils/shared_pref_reminder_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  final SharedPrefReminderHelper prefs;

  SchedulingProvider({required this.prefs}) {
    getReminderOption();
  }

  late bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<void> getReminderOption() async {
    _isScheduled = await prefs.getReminderOption();
    notifyListeners();
  }

  Future<void> _setReminderOption(bool value) async {
    _isScheduled = value;
    await prefs.setReminderOption(value);
    notifyListeners();
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _setReminderOption(value);
    notifyListeners();
    if (_isScheduled) {
      print('Scheduling Restaurant Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Restaurant Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
