import 'package:flutter/material.dart';
import 'package:movella_app/constants/colors.dart';
import 'package:movella_app/constants/constants.dart';
import 'package:movella_app/core/login_page.dart';
import 'package:movella_app/core/main_page.dart';
import 'package:movella_app/core/splash_page.dart';

// TODO: welcome dialog

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        primarySwatch: ExtendedColors.chilledChilly,
        textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Poppins'),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(24),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(24),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(24),
            ),
          ),
        ),
      ),
      routes: {
        SplashPage.route: (context) => const SplashPage(),
        LoginPage.route: (context) => const LoginPage(),
        MainPage.route: (context) => const MainPage(),
      },
    );
  }
}
