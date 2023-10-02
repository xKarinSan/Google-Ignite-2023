import 'package:flutter/material.dart';
import '../../General/bottom_bar.dart';
import '../../FirebaseFeatures/authentication.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:localstorage/localstorage.dart';
import '../../General/loader.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final User? user = AuthHandler().currentUser;
  final LocalStorage currentUser = LocalStorage('current_user');
  final LocalStorage bottomBarStorage = LocalStorage('bottom_bar_state');

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
        currentUser.clear();
        bottomBarStorage.clear();
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
                  Lottie.asset(
                    'assets/animation_ln7de1mq.json',
                    // width: 300,
                    // height: 300,
                  ),
                  Text(currentUser.getItem("displayName") ?? "User name",
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),

                  // Text(currentUser.getItem("email") ?? "User Email"),
                  // Text(currentUser.getItem("photoURL") ?? "Photo URL"),
                  // Text(currentUser.getItem("userId") ?? "User ID"),
                  _signOutButton()
                ],
              ),
      ),
      bottomNavigationBar: isLoggingOut ? null : const BottomBar(),
    );
  }
}
