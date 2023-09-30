export "user_model.dart";
import "package:firebase_database/firebase_database.dart";

class User {
  String userId;
  String username;
  User(this.userId, this.username);

  Object getJson() {
    return {"userId": userId, "username": username};
  }
}



class UserMethods{}
