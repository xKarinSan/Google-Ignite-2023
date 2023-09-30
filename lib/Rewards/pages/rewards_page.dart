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
              preferredSize: Size.fromHeight(120.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You have:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '1000 points',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
          body: TabBarView(
            children: [
              RedeemTab(),
              MyCouponsTab(),
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
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              CouponCard(
                imagePath: 'assets/Subway-logo.png',
                store: 'Subway',
                discount: '\$10 off',
                points: '1000 points',
              ),
              CouponCard(
                imagePath: 'assets/PKL.png',
                store: "Park's Kitchen",
                discount: '\$2 dollars off',
                points: '50 points',
              ),
              CouponCard(
                imagePath: 'assets/logo-kuro_kare.png',
                store: 'Kuro Kare',
                discount: 'Free Drink',
                points: '350 points',
              ),
              CouponCard(
                imagePath: 'assets/GC.png',
                store: 'Gong Cha',
                discount: 'Free Topping',
                points: '400 points',
              ),
              CouponCard(
                imagePath: 'assets/yole.png',
                store: 'Yole',
                discount: '1 for 1',
                points: '600 points',
              ),
              CouponCard(
                imagePath: 'assets/Ima.png',
                store: 'Ima Sushi',
                discount: '10% off',
                points: '350 points',
              ),
              CouponCard(
                imagePath: 'assets/khoon.png',
                store: 'Khoon Coffee House',
                discount: 'Free Upgrade',
                points: '400 points',
              ),
              CouponCard(
                imagePath: 'assets/Sub.png',
                store: 'Subarashii Super Don',
                discount: 'Free Drink',
                points: '300 points',
              ),
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
        children: [
          // Add your coupons for the "My Coupons" tab here
        ],
      ),
    );
  }
}

class CouponCard extends StatelessWidget {
  final String imagePath;
  final String store;
  final String discount;
  final String points;

  const CouponCard({
    required this.imagePath,
    required this.store,
    required this.discount,
    required this.points,
    Key? key,
  }) : super(key: key);

  void _showRedeemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Redeem $store voucher?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Redeem',
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showRedeemDialog(context);
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.5, // Set the aspect ratio for the image
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
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
                          fontSize: 14, // Adjust the font size
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        store,
                        style: TextStyle(
                          fontSize: 12, // Adjust the font size
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        points,
                        style: TextStyle(
                          fontSize: 12,
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
      ),
    );
  }
}
