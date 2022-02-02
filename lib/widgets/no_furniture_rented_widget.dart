import 'package:flutter/material.dart';
import 'package:movella_app/utils/services/localization.dart';
import 'package:movella_app/widgets/custom_error_widget.dart';
import 'package:movella_app/widgets/custom_icon.dart';

class NoFurnitureRentedWidget extends StatelessWidget {
  const NoFurnitureRentedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              child: const CustomIcon(CustomIcons.undrawEmpty),
              constraints: const BoxConstraints(
                maxHeight: 200,
                maxWidth: 200,
              ),
            ),
          ),
        ),
        CustomErrorWidget(
          message:
              Localization.localize(context).youHaventRentedAnyFurnitureYet,
        ),
      ],
    );
  }
}
