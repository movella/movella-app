import 'package:flutter/material.dart';
import 'package:movella_app/core/login_page.dart';
import 'package:movella_app/core/main_page.dart';
import 'package:movella_app/models/user.dart';
import 'package:movella_app/providers/app_provider.dart';
import 'package:movella_app/utils/services/shared_preferences.dart';
import 'package:movella_app/widgets/custom_icon.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static const route = '/';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      final authorization = await Prefs.getAuthorization;

      if (!mounted) return null;

      if (authorization == null) {
        return await Navigator.of(context)
            .pushReplacementNamed(LoginPage.route);
      }

      try {
        final validateResponse = await User.validate();

        if (!mounted) return null;

        Provider.of<AppProvider>(context, listen: false).user =
            validateResponse;

        await Navigator.of(context).pushReplacementNamed(MainPage.route);
      } catch (e) {
        if (!mounted) return null;

        await Navigator.of(context).pushReplacementNamed(LoginPage.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                child: const CustomIcon(CustomIcons.movella),
                constraints: const BoxConstraints(
                  maxHeight: 400,
                  maxWidth: 400,
                ),
              ),
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
