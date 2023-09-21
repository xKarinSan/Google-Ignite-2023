import 'package:flutter/material.dart';

import '../../General/bottom_bar.dart';

void main() {
  runApp(const ContestPage());
}

class ContestPage extends StatelessWidget {
  const ContestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Home'),
        // ),
        body: const Center(
          child: Text('Contests'),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
