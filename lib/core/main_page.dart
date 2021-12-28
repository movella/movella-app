import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movella_app/constants/constants.dart';
import 'package:movella_app/core/splash_page.dart';
import 'package:movella_app/utils/services/shared_preferences.dart';
import 'package:movella_app/widgets/custom_icon.dart';
import 'package:movella_app/widgets/custom_spacer.dart';
import 'package:package_info/package_info.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const route = 'main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _dismissed = false;

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
                          '${AppLocalizations.of(context)!.memberSince} 12/12/2021',
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
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return DraggableScrollableSheet(
                            initialChildSize: .6,
                            builder: (context, scrollController) {
                              return Container(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: SafeArea(
                                  child: ListView(
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: ConstrainedBox(
                                          child: Center(
                                            child: Material(
                                              elevation: 3,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(8),
                                              ),
                                              child: CustomIcon(
                                                CustomIcons.movellaSmall,
                                              ),
                                            ),
                                          ),
                                          constraints: const BoxConstraints(
                                            maxWidth: 200,
                                            maxHeight: 200,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          AppLocalizations.of(context)!.aboutUs,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .aboutUsText,
                                        ),
                                      ),
                                      // TODO: fix
                                      SizedBox(
                                        height: 400,
                                        child: PageView(
                                          children: List.generate(3, (index) {
                                            return Card(
                                              margin: const EdgeInsets.all(16),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Image.network(
                                                        'https://via.placeholder.com/100',
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Text(
                                                      'Excepteur laboris et cillum culpa adipisicing amet aute nisi.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: TextButton(
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .next,
                                                      ),
                                                      onPressed: () {
                                                        // TODO: fix
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.help),
                    leading: const Icon(MdiIcons.help),
                    onTap: () {
                      // TODO: fix
                    },
                  ),
                  FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      final data = snapshot.data;

                      if (snapshot.hasError) return const CustomErrorWidget();

                      if (snapshot.connectionState == ConnectionState.done &&
                          data != null)
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '${data.appName} ${data.version}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                'Build ${data.buildNumber}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        );

                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: const Center(
                          child: const CircularProgressIndicator(),
                        ),
                      );
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
                            title: Text(AppLocalizations.of(context)!.signOut),
                            content: Text(
                              AppLocalizations.of(context)!.signOutOfAccount,
                            ),
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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView(
              padding: const EdgeInsets.only(bottom: 100),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '${_getGreetingString(context)}, Usuário!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    AppLocalizations.of(context)!.recommended,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(7, (index) {
                      return SizedBox(
                        width: 160,
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: InkWell(
                            onTap: () {
                              // TODO: fix
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Image.network(
                                  'https://via.placeholder.com/100',
                                  fit: BoxFit.cover,
                                  height: 100,
                                ),
                                // TODO: fix
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    left: 8,
                                    right: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // TODO: fix
                                      const Text('Cadeira'),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              // TODO: fix
                                              text: 'R\$ 23,00',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                            TextSpan(
                                              // TODO: fix
                                              text:
                                                  ' ${AppLocalizations.of(context)!.perMonth}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  ?.apply(fontSizeFactor: .8),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        // TODO: fix
                                        'Elit et laboris sint proident laboris incididunt amet et. Excepteur cillum non sunt sint ex elit quis velit pariatur.',
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    bottom: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // TODO: fix
                                      const Text('Usuário 2'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                // TODO: fix
                if (!_dismissed)
                  Dismissible(
                    key: const ValueKey('dismissible'),
                    child: Card(
                      margin: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                        bottom: 8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(AppLocalizations.of(context)!
                                .verifyAccountMessage),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: OutlinedButton(
                                child: Text(
                                  AppLocalizations.of(context)!.goToMyAccount,
                                ),
                                onPressed: () {
                                  // TODO: fix
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        _dismissed = true;
                      });
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 16,
                    right: 16,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.history,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                // TODO: fix
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ConstrainedBox(
                        child: const CustomIcon(CustomIcons.undrawEmpty),
                        constraints: const BoxConstraints(
                          maxHeight: 200,
                          maxWidth: 200,
                        ),
                      ),
                    ),
                    CustomErrorWidget(
                      message: AppLocalizations.of(context)!
                          .youHaventRentedAnyFurnitureYet,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton.icon(
                      icon: const Icon(MdiIcons.magnify),
                      label: Text(
                        AppLocalizations.of(context)!.searchForFurniture,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        // TODO: fix
                      },
                    ),
                  ),
                ),
              ],
            )
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

String _getGreetingString(BuildContext context) {
  final hour = DateTime.now().hour;

  if (hour >= 18) return AppLocalizations.of(context)!.goodEvening;

  if (hour >= 12) return AppLocalizations.of(context)!.goodAfternoon;

  return AppLocalizations.of(context)!.goodMorning;
}

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        message ?? AppLocalizations.of(context)!.somethingWentWrong,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
