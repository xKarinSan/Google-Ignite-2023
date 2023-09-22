import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleignite2023/firebase_options.dart';
import 'General/bottom_bar.dart';

// ================== pages ==================
import 'home/pages/home.dart';
import 'Recycling/Pages/bin_locator.dart';
import 'Contests/pages/all_contest_page.dart';
import 'Rewards/pages/rewards_page.dart';
import 'Profile/pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  print(dotenv.env['apiKey']);
  print(dotenv.env['appId']);
  print(dotenv.env['messagingSenderId']);
  print(dotenv.env['projectId']);
  print(dotenv.env['databaseURL']);
  print(dotenv.env['storageBucket']);
  Firebase.initializeApp(
      options:
           DefaultFirebaseOptions.currentPlatform
  //         FirebaseOptions(
  //   apiKey: dotenv.env['apiKey'] ?? '',
  //   appId: dotenv.env['appId'] ?? '',
  //   messagingSenderId: dotenv.env['messagingSenderId'] ?? '',
  //   projectId: dotenv.env['projectId'] ?? '',
  //   databaseURL: dotenv.env['databaseURL'] ?? '',
  //   storageBucket: dotenv.env['storageBucket'] ?? '',
  // )
  );
  runApp(const MyApp());
  print("Started");
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
