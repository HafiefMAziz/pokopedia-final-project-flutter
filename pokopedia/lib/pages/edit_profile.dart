import 'package:flutter/material.dart';
import 'package:pokopedia/provider/user_provider.dart';
import 'package:pokopedia/widgets/poko_app_bar.dart';
import 'package:provider/provider.dart';

import '../styles/styles.dart';
import '../widgets/alert_dialog.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String updatedUsername = "";
  String updatedFullname = "";
  String updatedEmail = "";
  String updatedAvatar = "";
  String updatedAddress = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updatedUsername =
          Provider.of<UserProvider>(context, listen: false).user!.username;
      updatedFullname =
          Provider.of<UserProvider>(context, listen: false).user!.fullname;
      updatedEmail =
          Provider.of<UserProvider>(context, listen: false).user!.email;
      updatedAvatar =
          Provider.of<UserProvider>(context, listen: false).user!.avatar;
      updatedAddress =
          Provider.of<UserProvider>(context, listen: false).user!.address;
    });
  }

  onButtonEditProfile() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).editProfile(
          updatedUsername,
          updatedAvatar,
          updatedFullname,
          updatedEmail,
          updatedAddress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userState, child) {
      final user = userState.user;
      final editProfileMessage = userState.editProfileMessage;
      if (editProfileMessage != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return AlertMessage(
                    titleMessage: "Message",
                    contentMessage: editProfileMessage);
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
                    initialValue: user!.fullname,
                    onChanged: (text) {
                      updatedFullname = text;
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
                    initialValue: user.username,
                    onChanged: (text) {
                      updatedUsername = text;
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
                    initialValue: user.email,
                    onChanged: (text) {
                      updatedEmail = text;
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
                    initialValue: user.avatar,
                    onChanged: (text) {
                      updatedAvatar = text;
                    },
                    style: TextStyle(
                        color: navy(),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.image_rounded,
                        color: navy(),
                      ),
                      labelText: 'Avatar',
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
                    initialValue: user.address,
                    onChanged: (text) {
                      updatedAddress = text;
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
                    onPressed: () => onButtonEditProfile(),
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
                        "Save Profile",
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
