import 'package:flutter/material.dart';
import '../../General/bottom_bar.dart';

void main() {
  runApp(const ProfilePage());
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
          child: Text('User Profile'),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
