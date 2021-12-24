import 'package:flutter/material.dart';
import 'package:movella_app/constants/colors.dart';
import 'package:movella_app/constants/constants.dart';
import 'package:movella_app/core/splash_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(primarySwatch: ExtendedColors.chilledChilly),
      routes: {
        SplashPage.route: (context) => SplashPage(),
      },
    );
  }
}
