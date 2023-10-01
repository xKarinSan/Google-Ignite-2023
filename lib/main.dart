// ================= packages =================
// ======= widget tree/middleware =======
import 'package:googleignite2023/Recycling/Pages/bin_locator.dart';

import "widget_tree.dart";

// ======= flutter =======
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:googleignite2023/firebase_options.dart';

// ======= firebase =======
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// ======= firebase options =======
import 'package:googleignite2023/firebase_options.dart';

// =================firebase init=================
// import "FirebaseCredentials/firebase_environment.dart";
// ================== pages ==================
// ======= homepage =======
import 'home/pages/home.dart';
import 'home/pages/recycling_tips.dart';

// ======= recycling/hunt related =======
import 'Recycling/Pages/pop_up.dart';

// ======= contests/competitions related =======
import 'Contests/pages/all_contest_page.dart';
import 'package:googleignite2023/Contests/pages/current_contest_page.dart';
import 'package:googleignite2023/Contests/pages/current_contest_ranking_page.dart';

// ======= rewards related =======
import 'Rewards/pages/rewards_page.dart';

// ======= profile related =======
import 'Profile/pages/profile_page.dart';

// ======= authentication =======
import 'Authentication/Pages/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        home: const WidgetTree(),
        routes: {
          // ======= homepage =======
          '/home': (context) => const HomePage(),
          '/tips': (context) => const RecyclingTipsPage(),

          // ======= recycling/hunt related =======
          '/recycling': (context) => const BinLocator(),
          '/pop-up': (context) => const Popup(),

          // ======= contests/competitions related =======
          '/contests': (context) => const ContestPage(),
          '/contests/current': (context) => const CurrentContestPage(),
          '/contests/current/dashboard': (context) => const ContestDashboardPage(),

          // ======= rewards related =======
          '/rewards': (context) => const RewardsPage(),
          // ======= profile related =======

          '/profile': (context) => ProfilePage(),

          // ======= authentication =======
          '/auth': (context) => const AuthPage(),
        });
  }
}
