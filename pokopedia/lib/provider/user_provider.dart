import 'package:flutter/material.dart';
import 'package:pokopedia/service/user_services.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final UserService _service = UserService();
  User? _user;
  User? get user => _user;
  String? accessToken;
  // String? get accesToken => _accesToken;
  bool loading = false;
  String? loginMessage;

  Future<void> login(String username, String password) async {
    loading = true;
    notifyListeners();
    final response = await _service.login(username, password);
    _user = response["userInfo"];
    accessToken = response["access_token"];
    if (response["error"] != null) {
      loginMessage = response["error"];
    }
    loading = false;
    notifyListeners();
  }
  void updateMessage(){
    loginMessage = null;
    notifyListeners();
  }
}
