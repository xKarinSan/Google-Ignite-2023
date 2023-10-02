import 'package:flutter/material.dart';
import 'package:googleignite2023/FirebaseFeatures/rewards_model.dart';
import 'package:localstorage/localstorage.dart';

// ignore: must_be_immutable
class MyCouponsTab extends StatefulWidget {
  const MyCouponsTab({Key? key}) : super(key: key);

  @override
  State<MyCouponsTab> createState() => _MyCouponsTabState();
}

class _MyCouponsTabState extends State<MyCouponsTab> {
  bool isLoading = true;

  List<dynamic> redeemedCoupons = [];

  final LocalStorage currentUser = LocalStorage('current_user');

  Future<void> getUserObtainedCoupons(String userId) async {
    List<Widget> couponCards = [];
    await RewardMethod().getAllUserRewards(userId: userId).then((value) {
      setState(() {
        redeemedCoupons = value;
        isLoading = false;
      });
    });
  }

  @override
  initState() {
    setState(() {
      isLoading = true;
    });
    String userId = currentUser.getItem("userId");
    getUserObtainedCoupons(userId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (dynamic coupon in redeemedCoupons)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.network(
                        coupon["imagePath"],
                        width: 50,
                        height: 50,
                        // fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 16), // Add spacing between image and text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coupon["storeName"],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              coupon["discount"],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
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
