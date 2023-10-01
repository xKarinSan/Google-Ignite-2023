import 'package:flutter/material.dart';
import '../../General/bottom_bar.dart';

void main() {
  runApp(const BinLocator());
}

class BinLocator extends StatelessWidget {
  const BinLocator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // appBar: AppBar(
        //   title: const Text('Bin Locator'),
        // ),
        body: Center(
          child: Text('Bin Locator'),
        ),
        bottomNavigationBar: BottomBar());
  }
}
