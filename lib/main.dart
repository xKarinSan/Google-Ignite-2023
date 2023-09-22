import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleignite2023/firebase_options.dart';
import 'General/bottom_bar.dart';

// =================firebase init=================
import "FirebaseCredentials/firebase_environment.dart";
// ================== pages ==================
import 'home/pages/home.dart';
import 'Recycling/Pages/bin_locator.dart';
import 'Contests/pages/all_contest_page.dart';
import 'Rewards/pages/rewards_page.dart';
import 'Profile/pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  HelperFunctions.firebaseInit();
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
        home: const HomePage(),
        routes: {
          '/home': (context) => const HomePage(),
          '/recycling': (context) => const BinLocator(),
          '/contests': (context) => const ContestPage(),
          '/rewards': (context) => const RewardsPage(),
          '/profile': (context) => const ProfilePage()
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
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
