export "user_model.dart";

class User {
  String userId;
  String username;
  User(this.userId, this.username);

  Object getJson() {
    return {"userId": userId, "username": username};
  }
}



class UserMethods{}
