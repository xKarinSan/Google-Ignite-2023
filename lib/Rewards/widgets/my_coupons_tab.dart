import 'package:flutter/material.dart';
import 'package:googleignite2023/FirebaseFeatures/rewards_model.dart';
import 'package:googleignite2023/FirebaseFeatures/user_model.dart';
import 'package:googleignite2023/General/loader.dart';
import 'package:googleignite2023/Rewards/widgets/redeem_tab.dart';
import 'package:googleignite2023/Rewards/widgets/redeemed_coupon.dart';
import 'package:localstorage/localstorage.dart';
import '../../General/bottom_bar.dart';

class MyCouponsTab extends StatelessWidget {
  MyCouponsTab({Key? key}) : super(key: key);

  List<RedeemedCoupon> redeemedCoupons = [];

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
