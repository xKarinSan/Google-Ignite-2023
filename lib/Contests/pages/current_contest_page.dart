import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:googleignite2023/FirebaseFeatures/database.dart';
import 'package:googleignite2023/General/loader.dart';
import 'package:localstorage/localstorage.dart';
import '../../FirebaseFeatures/competition_model.dart';
import "../../FirebaseFeatures/participants_model.dart";
import "../../General/bottom_bar.dart";
import "../helper_functions.dart";

class CurrentContestPage extends StatefulWidget {
  const CurrentContestPage({super.key});

  @override
  State<CurrentContestPage> createState() => _CurrentContestPageState();
}

class _CurrentContestPageState extends State<CurrentContestPage> {
  final LocalStorage currentUser = LocalStorage('current_user');
  final LocalStorage bottom_bar = LocalStorage('bottom_bar_state');

  String id = "";
  String countdown = "";
  String userId = "";
  Timer? currTimer;
  bool isParticipant = false;
  bool isLoading = true;
  Map<dynamic, dynamic>? _competition;
  late Countdown _countdown;

  final DatabaseReference databaseReference =
      Database().setDatabaseReference("competitions");

  @override
  void initState() {
    super.initState();
    userId = currentUser.getItem("userId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bottom_bar.setItem('index', 2);
    });
    currTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown.calculateRemainingTime();
        countdown = _countdown.formattedRemainingTime;
        isLoading = false;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CompetitionMethods().getCompetitionById(id).then((res) {
        _competition = res;
        if (_competition == null) {
          Navigator.pushNamed(context, "/contests");
          return;
        }

        _countdown = Countdown(DateTime.fromMillisecondsSinceEpoch(
            _competition?["endDate"] ?? 0,
            isUtc: true));
        ParticipantMethod()
            .checkIfParticipantExists(competitionId: id, participantId: userId)
            .then((userIsParticipant) {
          isParticipant = userIsParticipant;
        });
      });
    });
  }

  @override
  void dispose() {
    currTimer?.cancel();
    super.dispose();
  }

  Future<void> joinCompetition() async {
    await ParticipantMethod()
        .createParticipant(competitionId: id, userId: userId);
    Navigator.pushNamed(context, '/contests/current/dashboard', arguments: {
      'competitionId': id,
    });
  }

  void enterCompetitionPage() async {
    Navigator.pushNamed(context, '/contests/current/dashboard', arguments: {
      'competitionId': id,
    });
  }

  // get the competition details
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    id = routeArgs['competitionId'].toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Contest"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
          child: isLoading
              ? const Loader(title: "Retrieving contest info...")
              : Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _competition?["competitionName"] ?? "Loading...",
                          style: const TextStyle(fontSize: 25),
                        ),
                        Text(
                          "Ends in: $countdown",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: isLoading
                              ? null
                              : ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.green)),
                                  onPressed: isParticipant
                                      ? enterCompetitionPage
                                      : joinCompetition,
                                  child: Text(
                                    isParticipant ? "View Dashboard" : "Join",
                                    style: const TextStyle(color: Colors.white),
                                  ))),
                    ),
                  ],
                ),
        ),
      ]),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
