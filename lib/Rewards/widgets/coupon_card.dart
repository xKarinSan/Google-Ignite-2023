import 'package:flutter/material.dart';
import 'package:googleignite2023/FirebaseFeatures/rewards_model.dart';
import 'package:googleignite2023/FirebaseFeatures/user_model.dart';
import 'package:localstorage/localstorage.dart';

class CouponCard extends StatefulWidget {
  final String imagePath;
  final String vendorName;
  final String discount;
  final String points;

  const CouponCard({
    required this.imagePath,
    required this.vendorName,
    required this.discount,
    required this.points,
    Key? key,
  }) : super(key: key);

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  final LocalStorage currentUser = LocalStorage("current_user");

// ================= dialog box =================
  void _showRedeemDialog(BuildContext context, String storeName,
      String discount, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Would you like to redeem a ${widget.vendorName} voucher?',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  int voucherPoints = int.parse(widget.points.split(' ')[0]);
                  Map<dynamic, dynamic> currUser = await UserMethods()
                      .getUserById(currentUser.getItem("userId"));
                  int userPoints = currUser['currentPoints'];
                  if (userPoints >= voucherPoints) {
                    // trigger the function
                    await RewardMethod().redeemReward(
                        userId: currentUser.getItem("userId"),
                        storeName: storeName,
                        discount: discount,
                        imagePath: imagePath,
                        points: voucherPoints);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RedeemDialog(
                          isSuccess: true,
                          message:
                              "You have redeemed a ${widget.vendorName} voucher. You have ${userPoints - voucherPoints} points left.",
                        );
                      },
                    );
                  } else {
                    // Display insufficient points message.
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const RedeemDialog(
                            isSuccess: false, message: "Insufficient funds!");
                      },
                    );
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: const BorderSide(color: Colors.green)))),
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.green),
                )),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(color: Colors.red)))),
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

  // ================main compoenent=================
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        _showRedeemDialog(
            context, widget.vendorName, widget.discount, widget.imagePath);
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
                    widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.discount,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20, // Adjust the font size
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.vendorName,
                        style: const TextStyle(
                          fontSize: 18, // Adjust the font size
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${widget.points} points",
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

class FailedDialog extends StatelessWidget {
  const FailedDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
  }
}

class RedeemDialog extends StatelessWidget {
  const RedeemDialog({
    super.key,
    required this.isSuccess,
    required this.message,
  });

  final String message;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          isSuccess ? const Text('Redemption success!') : const Text('Redemption failed!'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'OK',
            style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
          ),
        ),
      ],
    );
  }
}
