import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefReminderHelper {
  static SharedPrefReminderHelper? _instance;

  SharedPrefReminderHelper._internal();

  factory SharedPrefReminderHelper() =>
      _instance ?? SharedPrefReminderHelper._internal();

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static const String reminderPrefsKey = 'REMINDER_PREFS_KEY';

  Future<bool> getReminderOption() async {
    final prefs = await _prefs;
    return prefs.getBool(reminderPrefsKey) ?? false;
  }

  Future<void> setReminderOption(bool value) async {
    final prefs = await _prefs;
    prefs.setBool(reminderPrefsKey, value);
  }
}
