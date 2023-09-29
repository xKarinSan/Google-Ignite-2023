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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Rewards',
              style:
                  TextStyle(color: Colors.green)), // Change text color to green
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Redeem'),
              Tab(text: 'My Coupons'),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height *
                  0.25, // 25% of the screen height
              color: Colors.grey, // Rectangle background color
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'You have:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '1000 points',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Rewards',
                        style: TextStyle(
                            color: Colors.green)), // Change text color to green
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
            ),
          ],
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
            width: 80, // Make the image smaller based on its width
            height: 80, // Make the image smaller based on its width
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
