export 'firebase_environment.dart';

import 'package:googleignite2023/firebase_options.dart';
import "package:firebase_core/firebase_core.dart";

class HelperFunctions {
  static void firebaseInit() {
    // Launch a web view.
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
}
