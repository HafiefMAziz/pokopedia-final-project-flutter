import 'package:flutter/material.dart';
import 'package:pokopedia/provider/user_provider.dart';
import 'package:pokopedia/widgets/poko_app_bar.dart';
import 'package:provider/provider.dart';

import '../styles/styles.dart';
import '../widgets/alert_dialog.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String oldPassword = "";
  String newPassword = "";
  String confirmNewPassword = "";
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  onButtonChangePassword() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).changePassword(
          oldPassword, newPassword, confirmNewPassword);
    });
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userState, child) {
      final changePasswordMessage = userState.changePasswordMessage;
      if (changePasswordMessage != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return AlertMessage(
                    titleMessage: "Message",
                    contentMessage: changePasswordMessage);
              });
          Provider.of<UserProvider>(context, listen: false).updateMessage();
        });
      }
      return Scaffold(
        appBar: const PokoAppBar3(
          title: "Edit Profile",
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextFormField(
                    controller: oldPasswordController,
                    obscureText: true,
                    onChanged: (text) {
                      oldPassword = text;
                    },
                    style: TextStyle(
                        color: navy(),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: navy(),
                      ),
                      labelText: 'Old Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    onChanged: (text) {
                      newPassword = text;
                    },
                    style: TextStyle(
                        color: navy(),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_open_rounded,
                        color: navy(),
                      ),
                      labelText: 'New Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextFormField(
                    controller: confirmNewPasswordController,
                    obscureText: true,
                    onChanged: (text) {
                      confirmNewPassword = text;
                    },
                    style: TextStyle(
                        color: navy(),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_reset_outlined,
                        color: navy(),
                      ),
                      labelText: 'Confirm New Password ',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () => onButtonChangePassword(),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(red()),
                        shape: const MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        )),
                    child: const Padding(
                      padding: EdgeInsets.all(9.0),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
