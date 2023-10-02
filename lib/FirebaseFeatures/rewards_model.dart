import "package:firebase_database/firebase_database.dart";
import "./database.dart";
import "./user_model.dart";

class RewardMethod {
  Future<List> getAllAvailableRewards() async {
    try {
      return await Database().getAllDocumentsList(entityName: "rewards");
    } catch (e) {
      print(e);
      return [];
    }
  }

  // existing user redeems a reward
  Future<bool> redeemReward(
      {required String userId,
      required String storeName,
      required String discount,
      required String imagePath,
      required int points}) async {
    try {
      Map<dynamic, dynamic> currentUser =
          await UserMethods().getUserById(userId);
      int userPoints = currentUser['currentPoints'];
      userPoints -= points;
      if (userPoints < 0) {
        return false;
      }
      await UserMethods().updateUserPoints(userId: userId, points: userPoints);

      // add redeemed reward to userRewards
      DatabaseReference ref = Database().setDatabaseReference("userRewards");
      await ref.push().set({
        "userId": userId,
        "discount": discount,
        "storeName": storeName,
        "imagePath": imagePath,
        "isUsed": false,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

// get all the rewards user has
  Future<List> getAllUserRewards({required String userId}) async {
    try {
      Map<dynamic, dynamic> rewardMap = await Database().getDocumentByFieldMap(
          entityName: "userRewards", fieldName: "userId", fieldValue: userId);
      List res = [];
      print("rewardMap $rewardMap");
      rewardMap.forEach((key, value) {
        res.add(value);
      });
      return res;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
