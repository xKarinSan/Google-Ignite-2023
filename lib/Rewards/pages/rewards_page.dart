import 'package:flutter/material.dart';
import '../../General/bottom_bar.dart';

void main() {
  runApp(const RewardsPage());
}

class RewardsPage extends StatelessWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Rewards'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Redeem'),
                Tab(text: 'My Coupons'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              RedeemTab(),
              MyCouponsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class RedeemTab extends StatelessWidget {
  const RedeemTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        couponCard(
          'assets/images/pizza.png',
          '1000 points',
          'Canadian Pizza',
          '10 Discount',
        ),
        couponCard(
          'assets/images/pizza.png',
          '1000 points',
          'Canadian Pizza',
          '10 Discount',
        ),
        couponCard(
          'assets/images/pizza.png',
          '1000 points',
          'Canadian Pizza',
          '10 Discount',
        ),
      ],
    );
  }
}

class MyCouponsTab extends StatelessWidget {
  const MyCouponsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Coupons'),
    );
  }
}

Widget couponCard(
  String imagePath,
  String points,
  String store,
  String discount,
) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                discount,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(store),
              SizedBox(height: 8),
              Text(points),
            ],
          ),
        ],
      ),
    ),
  );
}
