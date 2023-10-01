import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:googleignite2023/Contests/pages/all_contest_page.dart';
import 'package:localstorage/localstorage.dart';
import '../../FirebaseFeatures/competition_model.dart';
import "../../FirebaseFeatures/participants_model.dart";
import "../../General/bottom_bar.dart";
import "../helper_functions.dart";
import "../../FirebaseFeatures/participants_model.dart";

class CurrentContestPage extends StatefulWidget {
  const CurrentContestPage({super.key});

  @override
  State<CurrentContestPage> createState() => _CurrentContestPageState();
}

class _CurrentContestPageState extends State<CurrentContestPage> {
  final LocalStorage currentUser = LocalStorage('current_user');
  String id = "";
  String countdown = "";
  String userId = "";
  Timer? currTimer;
  Map<dynamic, dynamic>? _competition;
  late Countdown _countdown;

  @override
  void initState() {
    super.initState();
    userId = currentUser.getItem("userId");
    currTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown.calculateRemainingTime();
        countdown = _countdown.formattedRemainingTime;
      });
    });

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      CompetitionMethods().getCompetitionById(id).then((res) {
        _competition = res as Map<dynamic, dynamic>?;
        if (_competition == null) {
          Navigator.pushNamed(context, "/contests");
          return;
        }

        _countdown = Countdown(DateTime.fromMillisecondsSinceEpoch(
            _competition?["endDate"] ?? 0,
            isUtc: true));
        ParticipantMethod()
            .checkIfParticipantExists(competitionId: id, participantId: userId)
            .then((isParticipant) {
          if (!isParticipant) {
            print("Not a participant");
          } else {
            print("participant");
          }
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
  }

  // get the competition details
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    id = routeArgs['competitionId'].toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Contest"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _competition?["competitionName"] ?? "Loading...",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Ends in: $countdown",
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: joinCompetition, child: Text("Join"))),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
