import 'package:flutter/material.dart';
import 'package:movella_app/providers/app_provider.dart';
import 'package:movella_app/utils/services/localization.dart';
import 'package:movella_app/widgets/custom_error_widget.dart';
import 'package:movella_app/widgets/email_text_form_field.dart';
import 'package:movella_app/widgets/username_text_form_field.dart';
import 'package:provider/provider.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  static const route = 'my_account';

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  Future<void> _update() async {
    // TODO: fix
  }

  @override
  void initState() {
    super.initState();

    final user = Provider.of<AppProvider>(context, listen: false).user;

    if (user != null) {
      _usernameController.text = user.username;
      _emailController.text = user.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: fix
      appBar: AppBar(title: Text(Localization.localize(context).myAccount)),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          final user = value.user;

          if (user == null) {
            return const CustomErrorWidget();
          }

          return Form(
            key: _formKey,
            child: ListView(
              children: [
                // TODO: fix
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        user.username,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        user.email,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Text(
                    // TODO: fix
                    'Geral',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: UsernameTextFormField(
                    focusNode: _usernameFocusNode,
                    controller: _usernameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: EmailTextFormField(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Text(
                    // TODO: fix
                    'Endereço',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: _update,
                    child: const Text(
                      // TODO: fix
                      'Atualizar perfil',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
