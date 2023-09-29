import 'package:flutter/material.dart';

import '../../General/bottom_bar.dart';

// void main() {
//   runApp(const HomePage());
// }

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text('Home'),
        ),
        bottomNavigationBar: BottomBar());
  }
}
