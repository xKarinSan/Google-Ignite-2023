import 'package:flutter/material.dart';
import 'package:googleignite2023/FirebaseFeatures/rewards_model.dart';
import 'package:googleignite2023/FirebaseFeatures/user_model.dart';
import 'package:localstorage/localstorage.dart';
import '../../General/bottom_bar.dart';

class RedeemedCoupon {
  final String storeName;
  final String discount;
  final String imagePath;

  RedeemedCoupon(this.storeName, this.discount, this.imagePath);
}

void main() {
  runApp(RewardsPage(userPoints: 1000)); // Provide a value for userPoints
}

class RewardsPage extends StatefulWidget {
  int userPoints; // Add a userPoints field

  RewardsPage({Key? key, required this.userPoints}) : super(key: key);

  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  int userCurrentPoints = 0;
  List<RedeemedCoupon> redeemedCoupons = [];
  final LocalStorage currentUser = new LocalStorage('current_user');

  void _addRedeemedCoupon(String storeName, String discount, String imagePath) {
    setState(() {
      redeemedCoupons.add(RedeemedCoupon(storeName, discount, imagePath));
    });
  }

  void _getUserCurrentPoints(String userId) {
    UserMethods().getUserById(userId).then((value) {
      print("[_getUserCurrentPoints] value $value");
      setState(() {
        userCurrentPoints = value['currentPoints'];
        print(userCurrentPoints);
      });
    });
  }

  @override
  void initState() {
    String userId = currentUser.getItem("userId");
    _getUserCurrentPoints(userId);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Rewards',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(160.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your points:"),
                      Text(
                        userCurrentPoints?.toString() ?? "0",
                        style: TextStyle(
                            fontSize: 22,
                            color: const Color.fromARGB(255, 2, 137, 6),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Explore and redeem various rewards offered by our participating merchants below:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                          height:
                              4), // Add some spacing between the title and points
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
            RedeemTab(
              userPoints: userCurrentPoints,
              addRedeemedCoupon: _addRedeemedCoupon, // Pass the function
            ),
            MyCouponsTab(redeemedCoupons: redeemedCoupons), // Pass the list
          ],
        ),
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}

class RedeemTab extends StatefulWidget {
  final int userPoints;
  final Function(String, String, String) addRedeemedCoupon;
  RedeemTab({
    Key? key,
    required this.userPoints,
    required this.addRedeemedCoupon,
  }) : super(key: key);

  @override
  State<RedeemTab> createState() => _RedeemTabState();
}

class _RedeemTabState extends State<RedeemTab> {
  @override
  initState() {
    super.initState();
    // upload all the rewards
    retrieveAllAvailableRewards();
  }

  // all the coupon cards
  List<Widget> allRewards = [];

  Future<void> retrieveAllAvailableRewards() async {
    // retrieve all the rewards
    List<Widget> tempRewardComponentList = [];

    RewardMethod().getAllAvailableRewards().then((res) => {
          res.forEach((element) {
            print("element $element");
            tempRewardComponentList.add(CouponCard(
                imagePath: element["imagePath"],
                store: element["vendorName"],
                discount: element["discount"],
                points: element["points"],
                userPoints: widget.userPoints,
                addRedeemedCoupon: widget.addRedeemedCoupon));
          }),
          setState(() {
            allRewards = tempRewardComponentList;
          })
        });

    // setState(() {
    //   rewards = rewards;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: allRewards,
          ),
        ],
      ),
    );
  }
}

class MyCouponsTab extends StatelessWidget {
  final List<RedeemedCoupon> redeemedCoupons;

  MyCouponsTab({Key? key, required this.redeemedCoupons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (RedeemedCoupon coupon in redeemedCoupons)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.network(
                        coupon.imagePath,
                        width: 50,
                        height: 50,
                        // fit: BoxFit.cover,
                      ),
                      SizedBox(width: 16), // Add spacing between image and text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coupon.storeName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              coupon.discount,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),


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
  final int userPoints;
  final Function(String, String, String) addRedeemedCoupon;

  const CouponCard({
    required this.imagePath,
    required this.store,
    required this.discount,
    required this.points,
    required this.userPoints,
    required this.addRedeemedCoupon,
    Key? key,
  }) : super(key: key);

  void _showRedeemDialog(BuildContext context, int userPoints, String storeName,
      String discount, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Would you like to redeem a $store voucher?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  int voucherPoints = int.parse(points.split(' ')[0]);
                  if (userPoints >= voucherPoints) {
                    // Deduct points and update the userPoints property.
                    userPoints -= voucherPoints;

                    // Add the redeemed coupon to the list
                    addRedeemedCoupon(storeName, discount, imagePath);

                    // Update the text within the AlertDialog.
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Redemption success!'),
                          content: RichText(
                            text: TextSpan(
                              text:
                                  'You have redeemed a $store voucher. You have ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: '$userPoints',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' points left.',
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Display insufficient points message.
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('You have insufficient points.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.green),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.green))))),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.red)))),
              child: const Text(
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
        _showRedeemDialog(context, userPoints, store, discount, imagePath);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.5, // Set the aspect ratio for the image
                  child: Image.network(
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
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20, // Adjust the font size
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        store,
                        style: const TextStyle(
                          fontSize: 18, // Adjust the font size
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        points,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
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
