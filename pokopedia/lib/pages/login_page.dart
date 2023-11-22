import 'package:flutter/material.dart';
import 'package:pokopedia/pages/register_page.dart';
import 'package:pokopedia/styles/styles.dart';
import 'package:pokopedia/widgets/subtitle.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  final fieldTextUsername = TextEditingController();
  final fieldTextPassword = TextEditingController();
  void onButtonLogin() {
    Provider.of<UserProvider>(context, listen: false).login(username, password);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userState, child) {
      String? loginMessage = userState.loginMessage;
      if (loginMessage != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: lightBlue(),
                  title: const Subtitle(text: "Login Error", fontSize: 25),
                  content: Text(
                    loginMessage,
                    style: TextStyle(
                        color: navy(),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                        fieldTextUsername.clear();
                        fieldTextPassword.clear();
                      },
                      child: Text('OK',
                          style: TextStyle(
                              color: navy(),
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                    ),
                  ],
                );
              });
          Provider.of<UserProvider>(context, listen: false).updateMessage();
        });
      }
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  color: lightBlue(),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 0,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Image.asset("assets/images/login-chair.png",
                            fit: BoxFit.cover),
                      ),
                      Positioned(
                        left: 15,
                        top: 130,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(children: [
                          const Subtitle(text: "Welcome to", fontSize: 40),
                          Image.asset("assets/images/iconFont.png",
                              fit: BoxFit.cover)
                        ]),
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 40),
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextFormField(
                      controller: fieldTextUsername,
                      onChanged: (text) {
                        username = text;
                      },
                      style: TextStyle(
                          color: navy(),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_box_rounded,
                          color: navy(),
                        ),
                        labelText: 'Username',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: TextFormField(
                      controller: fieldTextPassword,
                      onChanged: (text) {
                        password = text;
                      },
                      obscureText: true,
                      style: TextStyle(
                          color: navy(),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          color: navy(),
                        ),
                        labelText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: onButtonLogin,
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
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Did'nt have account ?",
                          style: TextStyle(
                              color: navy(),
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: red(),
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      );
    });
  }
}
