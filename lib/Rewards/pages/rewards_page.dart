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
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Rewards',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Column(
                children: [
                  Text(
                    'You have:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '1000 points',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                  const TabBar(
                    tabs: [
                      Tab(text: 'Redeem'),
                      Tab(text: 'My Coupons'),
                    ],
                    labelColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    RedeemTab(),
                    MyCouponsTab(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: const BottomBar(),
        ),
      ),
    );
  }
}

class RedeemTab extends StatelessWidget {
  const RedeemTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: roundedCouponCard(
                      'assets/Subway-logo.png', // Adjusted image path
                      'Subway',
                      '10 dollars off',
                      '1000 points',
                    ),
                  ),
                  Expanded(
                    child: roundedCouponCard(
                      'assets/PKL.png', // Adjusted image path
                      'Park\'s Kitchen',
                      '2 dollars off',
                      '50 points',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: roundedCouponCard(
                      'assets/logo-kuro_kare.png', // Adjusted image path
                      'Kuro Kare',
                      'Free Drink',
                      '350 points',
                    ),
                  ),
                  Expanded(
                    child: roundedCouponCard(
                      'assets/GC.png', // Adjusted image path
                      'Gong Cha',
                      'Free Topping',
                      '400 points',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: roundedCouponCard(
                      'assets/yole.png', // Adjusted image path
                      'Yole',
                      '1 for 1',
                      '600 points',
                    ),
                  ),
                  Expanded(
                    child: roundedCouponCard(
                      'assets/GC.png', // Adjusted image path
                      'Gong Cha',
                      'Free Drink',
                      '900 points',
                    ),
                  ),
                ],
              ),
              // Add more RedeemTab content here
            ],
          ),
        ],
      ),
    );
  }
}

class MyCouponsTab extends StatelessWidget {
  const MyCouponsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  }
}

Widget roundedCouponCard(
  String imagePath,
  String store,
  String discount,
  String points,
) {
  return Container(
    margin: EdgeInsets.all(8.0),
    width: double.infinity,
    height: 220, // Adjusted height to accommodate text
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100, // Adjusted image height
              child: Image.asset(
                imagePath,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    discount,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // Adjusted font size
                    ),
                  ),
                  Text(
                    store,
                    style: TextStyle(
                      fontSize: 12, // Adjusted font size
                    ),
                  ),
                  SizedBox(height: 4), // Adjusted spacing
                  Text(
                    points,
                    style: TextStyle(
                      fontSize: 12, // Adjusted font size
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
