// ================= packages =================
// ======= widget tree/middleware =======
import "widget_tree.dart";

// ======= flutter =======
import 'package:flutter/material.dart';

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

// ======= recycling/hunt related =======
import 'Recycling/Pages/bin_locator.dart';

// ======= contests/competitions related =======
import 'Contests/pages/all_contest_page.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        home: const WidgetTree(),
        routes: {
          // ======= homepage =======
          '/home': (context) => const HomePage(),

          // ======= recycling/hunt related =======
          '/recycling': (context) => const BinLocator(),

          // ======= contests/competitions related =======
          '/contests': (context) => const ContestPage(),

          // ======= rewards related =======
          '/rewards': (context) => const RewardsPage(),
          // ======= profile related =======

          '/profile': (context) => ProfilePage(),

          // ======= authentication =======
          '/auth': (context) => const AuthPage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
          Center(), // This trailing comma makes auto-formatting nicer for build methods.
      // bottomNavigationBar: BottomBar(),
    );
  }
}
