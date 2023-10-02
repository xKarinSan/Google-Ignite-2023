export 'recycle_model.dart';
import "package:firebase_database/firebase_database.dart";
import "package:googleignite2023/FirebaseFeatures/user_model.dart";

import "./database.dart";

class RecycleMethods {
  Future<void> createRecycle({
    required String userId,
  }) async {
    try {
      DatabaseReference ref = Database().setDatabaseReference("recycles");

      // get user
      Map<dynamic, dynamic> user = await UserMethods().getUserById(userId);
      if (user.isEmpty) {
        return;
      }
      Map<dynamic, dynamic> participantMap = await Database()
          .getDocumentByFieldMap(
              entityName: "participant",
              fieldName: "userId",
              fieldValue: userId);
      participantMap.forEach((key, value) async {
        // key update
        await Database().updateDocument(
            collection: "participant",
            docId: key,
            data: {"cumulativePoints": value["cumulativePoints"] + 50});
      });
      await Database()
          .updateDocument(collection: "users", docId: userId, data: {
        "cumulativePoints": user["cumulativePoints"] + 50,
        "currentPoints": user["currentPoints"] + 50
      });
    }

    // await ref.push().set({});
    catch (e) {
      print(e);
    }
  }
}
