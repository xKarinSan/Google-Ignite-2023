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
      required int amount,
      required String rewardId}) async {
    try {
      DatabaseReference ref = Database().setDatabaseReference("userRewards");
      ref.push().set({
        "userId": userId,
        "rewardId": rewardId,
        "redeemed": false,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

// get all the rewards user has
  Future<List> getRedeemedRewards({required String userId}) async {
    Map<dynamic, dynamic> rewardMap = await Database().getDocumentByFieldMap(
        entityName: "reward", fieldName: "userId", fieldValue: userId);
    List res = [];
    rewardMap.forEach((key, value) {
      if (value["redeemed"] == true) {
        res.add(value);
      }
    });
    return res;
  }
}
