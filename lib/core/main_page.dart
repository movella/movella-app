import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movella_app/constants/constants.dart';
import 'package:movella_app/core/splash_page.dart';
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
      final ans = await showDialog(
        context: context,
        builder: (context) {
          // return Dialog(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.all(8),
          //           child: const Text('Olá', textAlign: TextAlign.center),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8),
          //         child: ElevatedButton(
          //           child: const Text('Entendi'),
          //           onPressed: () {
          //             // TODO: fix
          //             Navigator.of(context).pop();
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // );
          return Dialog(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Olá', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    child: const Text('Entendi', textAlign: TextAlign.center),
                    onPressed: () {
                      // TODO: fix
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
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
                    title: const Text('Estatísticas'),
                    leading: const Icon(MdiIcons.chartBar),
                    onTap: () {
                      // TODO: fix
                    },
                  ),
                  ListTile(
                    title: const Text('Sobre a Movella'),
                    leading: const Icon(MdiIcons.informationOutline),
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
                    child: const Text('Minha conta'),
                    onPressed: () {
                      // TODO: fix
                    },
                  ),
                  const CustomSpacer(size: 8),
                  OutlinedButton(
                    child: const Text('Meus móveis'),
                    onPressed: () {
                      // TODO: fix
                    },
                  ),
                  const CustomSpacer(size: 8),
                  TextButton(
                    child: const Text('Sair'),
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
                                child: const Text('Não'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Sim'),
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
