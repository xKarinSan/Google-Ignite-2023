export 'firebase_environment.dart';

import 'package:googleignite2023/firebase_options.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:firebase_auth/firebase_auth.dart';

class HelperFunctions {
  static void firebaseInit() async {
    // Launch a web view.
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}

class AuthHandler {
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
    } catch (error) {
      // Handle error
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
