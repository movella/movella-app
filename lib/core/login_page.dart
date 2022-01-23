import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movella_app/core/main_page.dart';
import 'package:movella_app/exceptions/invalid_request_exception.dart';
import 'package:movella_app/models/user.dart';
import 'package:movella_app/providers/app_provider.dart';
import 'package:movella_app/utils/services/localization.dart';
import 'package:movella_app/utils/services/shared_preferences.dart';
import 'package:movella_app/utils/services/validation.dart';
import 'package:movella_app/widgets/custom_icon.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final loginResponse = await User.login(
        email: email,
        password: password,
      );

      if (!mounted) return;

      await Prefs.setAutoEmail(email);

      if (!mounted) return;

      Provider.of<AppProvider>(context, listen: false).user = loginResponse;

      Navigator.of(context).pushReplacementNamed(MainPage.route);
    } on InvalidRequestException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(Localization.localize(context).somethingWentWrong)));
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      final autoEmail = await Prefs.getAutoEmail;

      if (autoEmail != null) {
        _emailController.text = autoEmail;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.secondaryVariant,
      ),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: const CustomIcon(CustomIcons.movellaSmall),
                      ),
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Material(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // TODO: fix
                              Text(
                                Localization.localize(context).helloThere,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(color: Colors.black),
                              ),
                              Text(Localization.localize(context).loginMessage),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 32,
                            right: 32,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                EmailTextFormField(
                                  focusNode: _emailFocusNode,
                                  controller: _emailController,
                                ),
                                PasswordTextFormField(
                                  focusNode: _passwordFocusNode,
                                  controller: _passwordController,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 32),
                                  child: ElevatedButton(
                                    onPressed: _login,
                                    child: Text(
                                      Localization.localize(context).login,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: OutlinedButton(
                                    child: Text(
                                      Localization.localize(context)
                                          .iDontHaveAnAccount,
                                      textAlign: TextAlign.center,
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
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmailTextFormField extends StatefulWidget {
  const EmailTextFormField({
    Key? key,
    this.focusNode,
    this.controller,
  }) : super(key: key);

  final FocusNode? focusNode;
  final TextEditingController? controller;

  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  bool _suffixFocused = false;

  void _updateSuffixFocus() {
    setState(() {
      _suffixFocused = widget.focusNode?.hasFocus == true &&
          widget.controller?.text.isNotEmpty == true;
    });
  }

  @override
  void initState() {
    super.initState();

    widget.focusNode?.addListener(() {
      _updateSuffixFocus();
    });
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        _updateSuffixFocus();
      },
      decoration: InputDecoration(
        labelText: Localization.localize(context).email,
        icon: const Icon(MdiIcons.account),
        suffix: IconButton(
          icon: Icon(
            MdiIcons.close,
            color: _suffixFocused
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
          ),
          onPressed: () {
            widget.controller?.clear();

            _updateSuffixFocus();
          },
        ),
      ),
      validator: (value) {
        value ??= '';

        if (!Validation.isEmail(value)) {
          return Localization.localize(context).invalidEmail;
        }
      },
    );
  }
}

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    Key? key,
    this.focusNode,
    this.controller,
  }) : super(key: key);

  final FocusNode? focusNode;
  final TextEditingController? controller;

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obscureText = true;
  bool _suffixFocused = false;

  void _updateSuffixFocus() {
    setState(() {
      _suffixFocused = widget.focusNode?.hasFocus == true;
    });
  }

  @override
  void initState() {
    super.initState();

    widget.focusNode?.addListener(() {
      _updateSuffixFocus();
    });
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(() {});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      focusNode: widget.focusNode,
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: Localization.localize(context).password,
        icon: const Icon(MdiIcons.lock),
        suffix: IconButton(
          icon: Icon(
            _obscureText ? MdiIcons.eye : MdiIcons.eyeOffOutline,
            color: _suffixFocused
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: (value) {
        value ??= '';

        if (!Validation.isLongerThan(value, 4)) {
          return Localization.localize(context).invalidPassword;
        }
      },
    );
  }
}
