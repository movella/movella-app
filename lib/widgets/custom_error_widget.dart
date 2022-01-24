import 'package:flutter/material.dart';
import 'package:movella_app/utils/services/localization.dart';

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
        message ?? Localization.localize(context).somethingWentWrong,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
