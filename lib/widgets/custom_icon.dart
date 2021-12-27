import 'package:flutter/material.dart';

enum CustomIcons {
  movella,
  movellaSmall,
  undrawEmpty,
  undrawLogin,
}

class CustomIcon extends StatelessWidget {
  const CustomIcon(
    this.customIcon, {
    Key? key,
    this.size = 32,
  }) : super(key: key);

  final double size;
  final CustomIcons customIcon;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _resolveAssetName(customIcon),
      isAntiAlias: true,
      filterQuality: FilterQuality.high,
    );
  }
}

String _resolveAssetName(CustomIcons customIcon) {
  return {
    CustomIcons.movella: 'assets/images/movella.png',
    CustomIcons.movellaSmall: 'assets/images/movellasmall.png',
    CustomIcons.undrawEmpty: 'assets/images/undraw-empty.png',
    CustomIcons.undrawLogin: 'assets/images/undraw-login.png',
  }[customIcon]!;
}
