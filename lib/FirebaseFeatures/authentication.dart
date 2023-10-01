export 'authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "../FirebaseFeatures/database.dart";
import 'package:localstorage/localstorage.dart';

class AuthHandler {
  final LocalStorage currUserLocalStorage = LocalStorage('current_user');

  // auth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // current logged user
  User? get currentUser => _firebaseAuth.currentUser;
  // auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // sign in (email auth)
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    // try {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    // }
    await currUserLocalStorage.setItem(
        'displayName',
        AuthHandler().currentUser?.displayName?.isNotEmpty ?? false
            ? AuthHandler().currentUser?.displayName
            : "");
    await currUserLocalStorage.setItem(
        'email',
        AuthHandler().currentUser?.email?.isNotEmpty ?? false
            ? AuthHandler().currentUser?.email
            : "");

    await currUserLocalStorage.setItem(
        'userId',
        AuthHandler().currentUser?.uid.isNotEmpty ?? false
            ? AuthHandler().currentUser?.uid
            : "");
    await currUserLocalStorage.setItem(
        'photoURL',
        AuthHandler().currentUser?.photoURL?.isNotEmpty ?? false
            ? AuthHandler().currentUser?.photoURL
            : "");
    //  catch (error) {
    //   print("error");
    //   print(error);
    // }
  }

  Future<void> createUserWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user as User;
      user.updateDisplayName(username);
      await Database().createDocumentWithExistingId(
          collection: "users",
          id: user.uid,
          data: {
            "username": username,
            "photoURL": "",
            "cumulativePoints": 0,
            "currentPoints": 0,
          });
      await currUserLocalStorage.setItem('userId', user.uid);
      await currUserLocalStorage.setItem('displayName', username);
      await currUserLocalStorage.setItem('email', email);
      await currUserLocalStorage.setItem(
          'photoURL',
          user.photoURL?.isNotEmpty ?? false
              ? AuthHandler().currentUser?.photoURL
              : "");
    } catch (error) {
      // Handle error
      print(error);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
