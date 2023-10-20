import 'package:flutter/material.dart';
import 'package:tracking_app/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
    // ignore: avoid_print
    print("User set in UserProvider: $_user");
  }
}
