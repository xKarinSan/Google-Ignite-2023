import 'FirebaseFeatures/authentication.dart';
import 'Authentication/Pages/auth_page.dart';
import "Home/pages/home.dart";
import "package:flutter/material.dart";
import 'package:localstorage/localstorage.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  // username
  final LocalStorage currentUser = LocalStorage('current_user');
  final LocalStorage bottomBarStorage = LocalStorage('bottom_bar_state');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthHandler().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            currentUser.setItem(
                'displayName',
                snapshot.data?.displayName?.isNotEmpty ?? false
                    ? AuthHandler().currentUser?.displayName
                    : "");
            currentUser.setItem(
                'email',
                snapshot.data?.email?.isNotEmpty ?? false
                    ? AuthHandler().currentUser?.email
                    : "");
            currentUser.setItem(
                'photoURL',
                snapshot.data?.photoURL?.isNotEmpty ?? false
                    ? AuthHandler().currentUser?.photoURL
                    : "");
            currentUser.setItem(
                'userId',
                snapshot.data?.uid.isNotEmpty ?? false
                    ? AuthHandler().currentUser?.uid
                    : "");
            return const HomePage();
          } else {
            currentUser.clear();
            bottomBarStorage.clear();
            return const AuthPage();
          }
        });
  }
}
