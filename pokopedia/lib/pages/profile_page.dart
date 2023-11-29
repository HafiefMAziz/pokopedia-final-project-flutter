import 'package:flutter/material.dart';
import 'package:pokopedia/pages/edit_profile.dart';
import 'package:pokopedia/provider/user_provider.dart';
import 'package:pokopedia/styles/styles.dart';
import 'package:pokopedia/widgets/loading.dart';
import 'package:pokopedia/widgets/subtitle.dart';
import 'package:provider/provider.dart';

import 'change_password.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    logout() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<UserProvider>(context, listen: false).logout();
      });
    }

    return Consumer<UserProvider>(builder: (context, userState, child) {
      final user = userState.user;
      final loading = userState.loading;
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: loading
                ? const PokoLoading(size: 100)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(
                          user!.avatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          user.fullname,
                          style: TextStyle(
                              color: navy(),
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const EditProfilePage()));
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: tropicalBlue()),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: lightBlue(),
                          title: Text(
                            "Edit Profile",
                            style: TextStyle(
                                color: navy(),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          leading: Icon(
                            Icons.edit_note_rounded,
                            color: navy(),
                            size: 35,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: red(),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const ChangePasswordPage()));
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: tropicalBlue()),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: lightBlue(),
                          title: Text(
                            "Change Password",
                            style: TextStyle(
                                color: navy(),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          leading: Icon(
                            Icons.lock_person,
                            color: navy(),
                            size: 35,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: red(),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: ListTile(
                          onTap: () {
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: tropicalBlue()),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: lightBlue(),
                          title: Text(
                            "Terms & Condition",
                            style: TextStyle(
                                color: navy(),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          leading: Icon(
                            Icons.sticky_note_2_rounded,
                            color: navy(),
                            size: 35,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: red(),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: ListTile(
                          onTap: () => logout(),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: tropicalBlue()),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: lightBlue(),
                          title: Text(
                            "Logout",
                            style: TextStyle(
                                color: navy(),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          leading: Icon(
                            Icons.exit_to_app_rounded,
                            color: navy(),
                            size: 35,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: red(),
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
