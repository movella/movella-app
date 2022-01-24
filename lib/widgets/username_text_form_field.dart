import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movella_app/utils/services/localization.dart';
import 'package:movella_app/utils/services/validation.dart';

class UsernameTextFormField extends StatefulWidget {
  const UsernameTextFormField({
    Key? key,
    this.focusNode,
    this.controller,
  }) : super(key: key);

  final FocusNode? focusNode;
  final TextEditingController? controller;

  @override
  _UsernameTextFormFieldState createState() => _UsernameTextFormFieldState();
}

class _UsernameTextFormFieldState extends State<UsernameTextFormField> {
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
        labelText: Localization.localize(context).username,
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

        if (!Validation.isLongerThan(value, 4)) {
          return Localization.localize(context).invalidUsername;
        }
      },
    );
  }
}
