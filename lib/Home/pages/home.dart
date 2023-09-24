import 'package:flutter/material.dart';

import '../../General/bottom_bar.dart';
import 'package:localstorage/localstorage.dart';

// void main() {
//   runApp(const HomePage());
// }

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: const Center(
          child: Text('Home'),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
