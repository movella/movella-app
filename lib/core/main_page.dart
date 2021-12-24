import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movella_app/constants/constants.dart';
import 'package:movella_app/core/splash_page.dart';
import 'package:movella_app/utils/services/shared_preferences.dart';
import 'package:movella_app/widgets/custom_icon.dart';
import 'package:movella_app/widgets/custom_spacer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const route = 'main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      if (await Prefs.getShowWelcomeDialog) {
        final ans = await showDialog(
          context: context,
          builder: (context) {
            return const WelcomeDialogWidget();
          },
        );

        if (ans == true) await Prefs.setShowWelcomeDialog(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Constants.appName)),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Usuário'),
                        Text(
                          '3 aluguéis realizados',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          'Membro desde 12/12/2021',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.statistics),
                    leading: const Icon(MdiIcons.chartBar),
                    onTap: () {
                      // TODO: fix
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.about),
                    leading: const Icon(MdiIcons.informationOutline),
                    onTap: () {
                      // TODO: fix
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.help),
                    leading: const Icon(MdiIcons.help),
                    onTap: () {
                      // TODO: fix
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    child: Text(
                      AppLocalizations.of(context)!.myAccount,
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      // TODO: fix
                    },
                  ),
                  const CustomSpacer(size: 8),
                  OutlinedButton(
                    child: Text(
                      AppLocalizations.of(context)!.myFurniture,
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      // TODO: fix
                    },
                  ),
                  const CustomSpacer(size: 8),
                  TextButton(
                    child: Text(
                      AppLocalizations.of(context)!.signOut,
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () async {
                      // TODO: fix
                      final ans = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Atenção'),
                            content: const Text('Deseja sair de sua conta?'),
                            actions: [
                              TextButton(
                                child: Text(AppLocalizations.of(context)!.no),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(AppLocalizations.of(context)!.yes),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          );
                        },
                      );

                      if (mounted && ans == true)
                        Navigator.of(context)
                            .pushReplacementNamed(SplashPage.route);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Boa tarde, Usuário!',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeDialogWidget extends StatefulWidget {
  const WelcomeDialogWidget({Key? key}) : super(key: key);

  @override
  _WelcomeDialogWidgetState createState() => _WelcomeDialogWidgetState();
}

class _WelcomeDialogWidgetState extends State<WelcomeDialogWidget> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Olá!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ConstrainedBox(
                    child: const CustomIcon(CustomIcons.undrawLogin),
                    constraints: const BoxConstraints(maxHeight: 300),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Seja bem-vindo(a) à Movella!'),
                      const Text(''),
                      const Text(
                        'Aqui você pode alugar os móveis que precisa, ou colocar seus móveis para alugar e ganhar um dinheirinho extra.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CheckboxListTile(
            value: _checked,
            title: const Text('Não mostrar novamente'),
            onChanged: (value) {
              setState(() {
                _checked = !_checked;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              child: const Text('Entendi', textAlign: TextAlign.center),
              onPressed: () {
                Navigator.of(context).pop(_checked);
              },
            ),
          ),
        ],
      ),
    );
  }
}
