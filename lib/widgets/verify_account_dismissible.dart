import 'package:flutter/material.dart';
import 'package:movella_app/providers/app_provider.dart';
import 'package:movella_app/utils/services/localization.dart';
import 'package:provider/provider.dart';

class VerifyAccountDismissable extends StatefulWidget {
  const VerifyAccountDismissable({
    Key? key,
    required this.myAccount,
  }) : super(key: key);

  final Future<void> Function() myAccount;

  @override
  _VerifyAccountDismissableState createState() =>
      _VerifyAccountDismissableState();
}

class _VerifyAccountDismissableState extends State<VerifyAccountDismissable> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, value, child) {
        return Visibility(
          visible: !_dismissed && value.user?.access == 'default',
          child: Dismissible(
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
                    Text(Localization.localize(context).verifyAccountMessage),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: OutlinedButton(
                        onPressed: widget.myAccount,
                        child: Text(
                          Localization.localize(context).goToMyAccount,
                        ),
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
        );
      },
    );
  }
}
