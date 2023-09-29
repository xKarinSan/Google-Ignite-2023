import 'package:flutter/material.dart';
import '../../General/bottom_bar.dart';

void main() {
  runApp(const Popup());
}

class Popup extends StatelessWidget {
  const Popup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Pop Up'),
        // ),
        body: const Center(
          child: Text('Pop Up'),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
