import 'package:shared_preferences/shared_preferences.dart';

enum PrefsKeys { authorization, autoEmail, showWelcomeDialog }

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

  static Future<String?> get getAutoEmail async =>
      (await pref).getString(PrefsKeys.autoEmail.toString());

  static Future<void> setAutoEmail(String? autoEmail) async => autoEmail == null
      ? (await pref).remove(PrefsKeys.autoEmail.toString())
      : (await pref).setString(PrefsKeys.autoEmail.toString(), autoEmail);

  static Future<String?> get getAuthorization async =>
      (await pref).getString(PrefsKeys.authorization.toString());

  static Future<void> setAuthorization(String? authorization) async =>
      authorization == null
          ? (await pref).remove(PrefsKeys.authorization.toString())
          : (await pref)
              .setString(PrefsKeys.authorization.toString(), authorization);
}
