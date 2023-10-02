import 'package:flutter/material.dart';
import 'package:googleignite2023/FirebaseFeatures/rewards_model.dart';
import 'package:googleignite2023/General/loader.dart';
import 'package:googleignite2023/Rewards/widgets/coupon_card.dart';

class RedeemTab extends StatefulWidget {
  const RedeemTab({super.key});

  @override
  State<RedeemTab> createState() => _RedeemTabState();
}

class _RedeemTabState extends State<RedeemTab> {
  bool isLoading = true;
  List<Widget> allCoupons = [];

// initialise showing of the rewards

  Future<void> getAllCoupons() async {
    List<Widget> couponCards = [];
    await RewardMethod().getAllAvailableRewards().then((value) {
      value.forEach((element) => {
            print(element),
            couponCards.add(CouponCard(
              imagePath: element["imagePath"],
              vendorName: element["vendorName"],
              points: element["points"],
              discount: element["discount"],
            ))
          });
      setState(() {
        allCoupons = couponCards;
        isLoading = false;
      });
    });
  }

// init
  @override
  initState() {
    setState(() {
      isLoading = true;
    });
    getAllCoupons();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: isLoading
          ? const Loader(title: "Retrieving rewards ...")
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: allCoupons,
            ),
    );
  }
}
