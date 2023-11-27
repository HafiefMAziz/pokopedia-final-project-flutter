import 'package:flutter/material.dart';
import 'package:pokopedia/service/user_services.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final UserService _service = UserService();
  User? _user;
  User? get user => _user;
  String? accessToken;
  bool loading = false;
  String? loginMessage;
  String? registerMessage;

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
  Future<void> register(username, password, fullname, email, address) async {
    loading = true;
    notifyListeners();
    final response = await _service.register(username, password, fullname, email, address);
    if (response["error"] != null) {
      registerMessage = response["error"];
    }else{
      registerMessage = response["message"];
    }
    loading = false;
    notifyListeners();
  }
  void updateMessage(){
    loginMessage = null;
    registerMessage = null;
    notifyListeners();
  }
}
