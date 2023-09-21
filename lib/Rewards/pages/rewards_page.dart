import 'package:flutter/material.dart';
import '../../General/bottom_bar.dart';

void main() {
  runApp(const RewardsPage());
}

class RewardsPage extends StatelessWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
          child: Text('Rewards'),
        ),
        bottomNavigationBar: const BottomBar());
  }
}
