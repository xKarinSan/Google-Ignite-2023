import 'package:flutter/material.dart';
import '../../General/bottom_bar.dart';
import "../../../FirebaseCredentials/firebase_environment.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:localstorage/localstorage.dart';
import '../../General/loader.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final User? user = AuthHandler().currentUser;
  final LocalStorage currentUser = LocalStorage('current_user.json');

  bool isLoggingOut = false;

  Future<void> logoutUser() async {
    try {
      setState(() {
        isLoggingOut = true;
      });
      await AuthHandler().signOut().then((e) {
        setState(() {
          isLoggingOut = false;
        });
        Navigator.pushNamed(context, '/auth');
      }).catchError((onError) {
        isLoggingOut = false;
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      setState(() {
        isLoggingOut = false;
      });
    }
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: logoutUser,
      child: const Text("Sign Out"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoggingOut
            ? const Loader(title: "Logging out...")
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(currentUser.getItem("displayName") != null
                      ? currentUser.getItem("displayName")
                      : "User name"),
                  Text(currentUser.getItem("email") != null
                      ? currentUser.getItem("email")
                      : "User Email"),
                  Text(currentUser.getItem("photoURL") != null
                      ? currentUser.getItem("photoURL")
                      : "Photo URL"),
                  _signOutButton()
                ],
              ),
      ),
      bottomNavigationBar: isLoggingOut ? null : const BottomBar(),
    );
  }
}
