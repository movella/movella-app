import 'package:flutter/material.dart';

extension NavigatorStateExtension on NavigatorState {
  void safePop<T extends Object?>([T? result]) {
    if (canPop()) {
      pop<T>(result);
    }
  }
}
