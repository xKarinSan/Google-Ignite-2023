import '../FirebaseCredentials/firebase_environment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class RedirectHelper2 extends GetMiddleware {
//   var authService = Get.find<AuthHandler>();

//   @override
//   RouteSettings? redirect(String? route) {
//     // check if logged in
//     bool isLoggedIn = authService.currentUser != null;

//     // in auth
//     if (route == "/auth") {
//       // // if logged in, redirect to home
//       if (isLoggedIn) {
//         return RouteSettings(name: '/home');
//       }
//     }

//     // in any other pages
//     else {
//       // // if not login, redirect to auth
//       if (!isLoggedIn) {
//         return RouteSettings(name: '/auth');
//       }
//     }
//   }
// }

class RedirectHelper {
  static redirect(BuildContext context, String route) {
    // check if logged in
    bool isLoggedIn = AuthHandler().currentUser != null;

    // in auth
    if (route == "/auth") {
      // // if logged in, redirect to home
      if (isLoggedIn) {
        Navigator.pushNamed(context, '/home');
      }
    }

    // in any other pages
    else {
      // // if not login, redirect to auth
      if (!isLoggedIn) {
        Navigator.pushNamed(context, '/auth');
      }
    }
  }
}

class AuthMiddleware extends NavigatorObserver {
  String? lastRoute;

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    lastRoute = newRoute?.settings.name;
    // RedirectHelper.redirect(Get.context!, lastRoute!);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    lastRoute = route.settings.name;
    // RedirectHelper.redirect(Get.context!, lastRoute!);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    lastRoute = previousRoute?.settings.name;
    // RedirectHelper.redirect(Get.context!, lastRoute!);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    lastRoute = previousRoute?.settings.name;
    // RedirectHelper.redirect(Get.context!, lastRoute!);
  }
}
