import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movella_app/constants/colors.dart';
import 'package:movella_app/constants/constants.dart';
import 'package:movella_app/core/login_page.dart';
import 'package:movella_app/core/main_page.dart';
import 'package:movella_app/core/register_page.dart';
import 'package:movella_app/core/splash_page.dart';
import 'package:movella_app/modules/my_account_page.dart';
import 'package:movella_app/modules/my_furniture_page.dart';
import 'package:movella_app/modules/search_page.dart';
import 'package:movella_app/providers/app_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: Constants.appName,
        // locale: const Locale('pt'),
        // locale: const Locale('en'),
        supportedLocales: const [
          Locale('en'),
          Locale('pt'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
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
          SearchPage.route: (context) => const SearchPage(),
          RegisterPage.route: (context) => const RegisterPage(),
          MyFurniturePage.route: (context) => const MyFurniturePage(),
          MyAccountPage.route: (context) => const MyAccountPage(),
        },
      ),
    );
  }
}
