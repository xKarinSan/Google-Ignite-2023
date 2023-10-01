export "user_model.dart";
import "package:firebase_database/firebase_database.dart";

import "./database.dart";

class User {
  String userId;
  String username;
  User(this.userId, this.username);

  Object getJson() {
    return {"userId": userId, "username": username};
  }
}

class UserMethods {
  Future<void> createUser(
      {required String userId, required String username}) async {
    try {
      DatabaseReference ref = Database().setDatabaseReference("users");

      await ref.push().set({
        "userId": userId,
        "username": username,
      });
    } catch (e) {
      print(e);
    }
  }

  // get all users
  Future<List> getAllUsersList() async {
    return Database().getAllDocumentsList(entityName: "users");
  }

  Future<Map<dynamic, dynamic>> getAllUsersMap() async {
    return Database().getAllDocumentsMap(entityName: "users");
  }

  // get user by Id
  Future<Map<dynamic, dynamic>> getUserById(String userId) async {
    return Database().getDocumentById(entityName: "users", id: userId);
  }
}
