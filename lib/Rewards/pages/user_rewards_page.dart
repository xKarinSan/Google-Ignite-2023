import 'package:flutter/material.dart';
import 'package:googleignite2023/FirebaseFeatures/user_model.dart';
import 'package:googleignite2023/General/loader.dart';
import 'package:googleignite2023/Rewards/widgets/my_coupons_tab.dart';
import 'package:googleignite2023/Rewards/widgets/redeem_tab.dart';
import 'package:localstorage/localstorage.dart';
import '../../General/bottom_bar.dart';

class UserRewardsPage extends StatefulWidget {
  const UserRewardsPage({Key? key}) : super(key: key);

  @override
  State<UserRewardsPage> createState() => _UserRewardsPageState();
}

class _UserRewardsPageState extends State<UserRewardsPage> {
  bool isLoading = true;
  int userCurrentPoints = 0;
  List<dynamic> redeemedCoupons = [];
  final LocalStorage currentUser = LocalStorage('current_user');

  Future<void> _getUserCurrentPoints(String userId) async {
    setState(() {
      isLoading = true;
    });
    await UserMethods().getUserById(userId).then((value) {
      // print("[_getUserCurrentPoints] value $value");
      setState(() {
        userCurrentPoints = value['currentPoints'];
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    String userId = currentUser.getItem("userId");
    _getUserCurrentPoints(userId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isLoading
            ? const Loader(title: "Retrieving rewards ...")
            : DefaultTabController(
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
                                const Text("Your points:"),
                                Text(
                                  userCurrentPoints.toString() ?? "0",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color:
                                          Color.fromARGB(255, 2, 137, 6),
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'Explore and redeem various rewards offered by our participating merchants below:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
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
                  body: const TabBarView(
                    children: [
                      RedeemTab(),
                      MyCouponsTab(), // Pass the list
                    ],
                  ),
                  bottomNavigationBar: const BottomBar(),
                ),
              ));
  }
}
