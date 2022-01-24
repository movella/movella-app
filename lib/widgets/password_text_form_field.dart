import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movella_app/utils/services/localization.dart';
import 'package:movella_app/utils/services/validation.dart';

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
