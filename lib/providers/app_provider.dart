import 'package:flutter/cupertino.dart';
import 'package:movella_app/models/user.dart';

class AppProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  set user(User? user) {
    _user = user;

    notifyListeners();
  }
}
