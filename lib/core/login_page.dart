import 'package:flutter/material.dart';
import 'package:movella_app/widgets/custom_icon.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            Text(
                              'Olá!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(color: Colors.black),
                            ),
                            Text('Entre para continuar'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          left: 32,
                          right: 32,
                        ),
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
                                child: const Text(
                                  'Entrar',
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  // TODO: fix
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: OutlinedButton(
                                child: const Text(
                                  'Não tenho uma conta',
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
                    ],
                  ),
                ),
              ),
            )
          ],
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
      onChanged: (value) {
        _updateSuffixFocus();
      },
      decoration: InputDecoration(
        labelText: 'Email',
        icon: const Icon(Icons.person),
        suffix: IconButton(
          icon: Icon(
            Icons.close,
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
      decoration: InputDecoration(
        labelText: 'Senha',
        icon: const Icon(Icons.lock),
        suffix: IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
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
    );
  }
}
