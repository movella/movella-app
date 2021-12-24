import 'package:shared_preferences/shared_preferences.dart';

enum PrefsKeys { showWelcomeDialog }

class Prefs {
  static Future<SharedPreferences> get pref async =>
      await SharedPreferences.getInstance();

  static Future<bool> get getShowWelcomeDialog async =>
      (await pref).getBool(PrefsKeys.showWelcomeDialog.toString()) ?? true;

  static Future<void> setShowWelcomeDialog(bool? showWelcomeDialog) async =>
      showWelcomeDialog == null
          ? (await pref).remove(PrefsKeys.showWelcomeDialog.toString())
          : (await pref).setBool(
              PrefsKeys.showWelcomeDialog.toString(), showWelcomeDialog);
}
