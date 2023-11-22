import 'package:flutter/material.dart';
import 'package:pokopedia/provider/user_provider.dart';
import 'package:pokopedia/widgets/poko_app_bar.dart';
import 'package:provider/provider.dart';

import '../styles/styles.dart';
import '../widgets/subtitle.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username = "";
  String fullname = "";
  String email = "";
  String password = "";
  String address = "";

  void onButtonRegister() {
    Provider.of<UserProvider>(context, listen: false)
        .register(username, password, fullname, email, address);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userState, child) {
      final registerMessage = userState.registerMessage;
      if (registerMessage != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: lightBlue(),
                  title: const Subtitle(text: "Register Message", fontSize: 25),
                  content: Text(
                    registerMessage,
                    style: TextStyle(
                        color: navy(),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
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
        appBar: const PokoAppBar3(
          title: "Register",
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextFormField(
                    onChanged: (text) {
                      username = text;
                    },
                    style: TextStyle(
                        color: navy(),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.card_membership_rounded,
                        color: navy(),
                      ),
                      labelText: 'Fullname',
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
                    onChanged: (text) {
                      fullname = text;
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
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextFormField(
                    onChanged: (text) {
                      email = text;
                    },
                    style: TextStyle(
                        color: navy(),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.alternate_email_rounded,
                        color: navy(),
                      ),
                      labelText: 'Email',
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
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextFormField(
                    onChanged: (text) {
                      address = text;
                    },
                    style: TextStyle(
                        color: navy(),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on_rounded,
                        color: navy(),
                      ),
                      labelText: 'Address',
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
                    onPressed: onButtonRegister,
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
                        "Register",
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
