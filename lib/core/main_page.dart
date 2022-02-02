import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movella_app/constants/constants.dart';
import 'package:movella_app/core/splash_page.dart';
import 'package:movella_app/extensions/navigator_state_extension.dart';
import 'package:movella_app/modules/my_account_page.dart';
import 'package:movella_app/modules/my_furniture_page.dart';
import 'package:movella_app/modules/search_page.dart';
import 'package:movella_app/providers/app_provider.dart';
import 'package:movella_app/utils/services/localization.dart';
import 'package:movella_app/utils/services/networking.dart';
import 'package:movella_app/utils/services/shared_preferences.dart';
import 'package:movella_app/utils/services/socket_io.dart';
import 'package:movella_app/widgets/custom_error_widget.dart';
import 'package:movella_app/widgets/custom_icon.dart';
import 'package:movella_app/widgets/custom_spacer.dart';
import 'package:movella_app/widgets/no_furniture_rented_widget.dart';
import 'package:movella_app/widgets/verify_account_dismissible.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const route = 'main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  io.Socket? _socket;

  Future<void> _myFurniture() async {
    await Navigator.of(context).pushNamed(MyFurniturePage.route);
  }

  Future<void> _myAccount() async {
    await Navigator.of(context).pushNamed(MyAccountPage.route);
  }

  Future<void> _signOut() async {
    final ans = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(Localization.localize(context).signOut),
          content: Text(
            Localization.localize(context).signOutOfAccount,
          ),
          actions: [
            TextButton(
              child: Text(Localization.localize(context).no),
              onPressed: () {
                Navigator.of(context).safePop();
              },
            ),
            TextButton(
              child: Text(Localization.localize(context).yes),
              onPressed: () {
                Navigator.of(context).safePop(true);
              },
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (ans == true) {
      await Prefs.setAuthorization(null);

      if (!mounted) return;

      await Navigator.of(context).pushReplacementNamed(SplashPage.route);
    }
  }

  Future<void> _setupSocket() async {
    const authority = Constants.authority;

    _socket?.clearListeners();

    final socket = io.io(
      'http://$authority',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders(await Api.getHeaders)
          .build(),
    );

    socket.onConnectError((data) {
      if (kDebugMode) {
        print(data);
      }
    });

    socket.onError((data) {
      if (kDebugMode) {
        print(data);
      }
    });

    socket.onConnect((data) {
      if (kDebugMode) {
        print('socket connected');
      }

      _socket?.emitWithAck(SocketEvents.recommended, {}, ack: (dynamic data) {
        // TODO: fix
        if (kDebugMode) {
          print(data);
        }
      });
    });

    setState(() {
      _socket = socket;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      _setupSocket();

      if (await Prefs.getShowWelcomeDialog) {
        final ans = await showDialog(
          context: context,
          builder: (context) {
            return const WelcomeDialogWidget();
          },
        );

        if (ans == true) {
          await Prefs.setShowWelcomeDialog(false);
        }
      }
    });
  }

  @override
  void dispose() {
    _socket?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.appName)),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Consumer<AppProvider>(
                      builder: (context, value, child) {
                        final user = value.user;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(user?.username ?? ''),
                            Text(
                              // TODO: fix
                              '3 aluguéis realizados',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              '${Localization.localize(context).memberSince} 12/12/2021',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(
                              // TODO: fix
                              user?.access ?? '',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(Localization.localize(context).statistics),
                    leading: const Icon(MdiIcons.chartBar),
                    onTap: () {
                      // TODO: fix
                    },
                  ),
                  ListTile(
                    title: Text(Localization.localize(context).about),
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
                                          child: const Center(
                                            child: Material(
                                              elevation: 3,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
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
                                          Localization.localize(context)
                                              .aboutUs,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          Localization.localize(context)
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
                                                        8,
                                                      ),
                                                      child: Image.network(
                                                        // TODO: fix
                                                        'https://via.placeholder.com/100',
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Text(
                                                      // TODO: fix
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
                                                        Localization.localize(
                                                                context)
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
                    title: Text(Localization.localize(context).help),
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
                          data != null) {
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
                      }

                      return const Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(child: CircularProgressIndicator()),
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
                    onPressed: _myAccount,
                    child: Text(
                      Localization.localize(context).myAccount,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const CustomSpacer(size: 8),
                  OutlinedButton(
                    onPressed: _myFurniture,
                    child: Text(
                      Localization.localize(context).myFurniture,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const CustomSpacer(size: 8),
                  TextButton(
                    onPressed: _signOut,
                    child: Text(
                      Localization.localize(context).signOut,
                      textAlign: TextAlign.center,
                    ),
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
                    '${_getGreetingString(context)}, ${Provider.of<AppProvider>(context).user?.username}!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    Localization.localize(context).recommended,
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
                                  // TODO: fix
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
                                                  ' ${Localization.localize(context).perMonth}',
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
                                    children: const [
                                      // TODO: fix
                                      Text('Usuário 2'),
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
                VerifyAccountDismissable(myAccount: _myAccount),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 16,
                    right: 16,
                  ),
                  child: Text(
                    Localization.localize(context).history,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                const NoFurnitureRentedWidget(),
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
                        Localization.localize(context).searchForFurniture,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        // TODO: fix
                        await Navigator.of(context).pushNamed(SearchPage.route);
                      },
                    ),
                  ),
                ),
              ],
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
                    Localization.localize(context).helloThere,
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
                      Text(Localization.localize(context).welcomeDialogMessage),
                      const Text(''),
                      Text(Localization.localize(context).welcomeDialogText),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CheckboxListTile(
            value: _checked,
            title: Text(Localization.localize(context).dontShowAgain),
            onChanged: (value) {
              setState(() {
                _checked = !_checked;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              child: Text(
                Localization.localize(context).gotIt,
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).safePop(_checked);
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

  if (hour >= 18) return Localization.localize(context).goodEvening;

  if (hour >= 12) return Localization.localize(context).goodAfternoon;

  return Localization.localize(context).goodMorning;
}
