import 'package:flutter/material.dart';
import 'package:googleignite2023/FirebaseFeatures/rewards_model.dart';
import 'package:googleignite2023/FirebaseFeatures/user_model.dart';
import 'package:googleignite2023/General/loader.dart';
import 'package:googleignite2023/Rewards/widgets/coupon_card.dart';
import 'package:localstorage/localstorage.dart';
import '../../General/bottom_bar.dart';

class RedeemTab extends StatefulWidget {
  const RedeemTab({super.key});

  @override
  State<RedeemTab> createState() => _RedeemTabState();
}

class _RedeemTabState extends State<RedeemTab> {
  bool isLoading = true;
  List<Widget> allCoupons = [];
  final LocalStorage currentUser = new LocalStorage('current_user');

// initialise showing of the rewards

  Future<void> getAllCoupons() async {
    List<Widget> couponCards = [];
    await RewardMethod().getAllAvailableRewards().then((value) {
      print("value $value");
      print(" ");
      print(value[0]);
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
          ? Loader(title: "Retrieving rewards ...")
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: allCoupons,
            ),
    );
  }
}
