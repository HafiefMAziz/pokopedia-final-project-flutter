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
  String? editProfileMessage;
  String? changePasswordMessage;

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
    if (username == "" ||
        password == "" ||
        fullname == "" ||
        email == "" ||
        address == "") {
      registerMessage = "There is field with null string";
    } else {
      final response =
          await _service.register(username, password, fullname, email, address);
      if (response["error"] != null) {
        registerMessage = response["error"];
      } else {
        registerMessage = response["message"];
      }
    }
    loading = false;
    notifyListeners();
  }

  Future<void> editProfile(username, avatar, fullname, email, address) async {
    loading = true;
    notifyListeners();
    final response = await _service.editProfile(
        accessToken, _user!.id, username, avatar, fullname, email, address);
    print(response);
    if (response["error"] != null) {
      editProfileMessage = response["error"];
    } else {
      _user = response["updatedData"];
      editProfileMessage = response["message"];
    }
    loading = false;
    notifyListeners();
  }

  Future<void> changePassword(
      oldPassword, newPassword, confirmNewPassword) async {
    loading = true;
    notifyListeners();
    final response = await _service.changePassword(
        accessToken, _user!.id, oldPassword, newPassword, confirmNewPassword);
    print(response);
    if (response["error"] != null) {
      changePasswordMessage = response["error"];
    } else {
      changePasswordMessage = response["message"];
    }
    loading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    loading = true;
    notifyListeners();
    accessToken = null;
    _user = null;
    loading = false;
    notifyListeners();
  }

  void updateMessage() {
    loginMessage = null;
    registerMessage = null;
    editProfileMessage = null;
    changePasswordMessage = null;
    notifyListeners();
  }
}
