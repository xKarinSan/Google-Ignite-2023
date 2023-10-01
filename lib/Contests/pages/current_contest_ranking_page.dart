import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:googleignite2023/Contests/helper_functions.dart';
import 'package:googleignite2023/FirebaseFeatures/competition_model.dart';
import 'package:googleignite2023/FirebaseFeatures/database.dart';
import 'package:googleignite2023/FirebaseFeatures/participants_model.dart';
import 'package:googleignite2023/General/bottom_bar.dart';
import 'package:googleignite2023/General/loader.dart';
import 'package:localstorage/localstorage.dart';

class ContestDashboardPage extends StatefulWidget {
  const ContestDashboardPage({Key? key}) : super(key: key);

  @override
  State<ContestDashboardPage> createState() => _ContestDashboardPageState();
}

class _ContestDashboardPageState extends State<ContestDashboardPage> {
  final LocalStorage currentUser = LocalStorage('current_user');
  String id = "";
  String countdown = "";
  String userId = "";
  Timer? currTimer;
  Map<dynamic, dynamic>? _competition;
  late Countdown _countdown;
  bool isLoading = true;

  List<Widget> userCompetitions = [];

  @override
  void initState() {
    super.initState();

    userId = currentUser.getItem("userId");
    currTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        isLoading = false;
        _countdown.calculateRemainingTime();
        countdown = _countdown.formattedRemainingTime;
      });
    });

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      CompetitionMethods().getCompetitionById(id).then((res) {
        _competition = res as Map<dynamic, dynamic>?;
        if (_competition == null) {
          return;
        }

        _countdown = Countdown(DateTime.fromMillisecondsSinceEpoch(
            _competition?["endDate"] ?? 0,
            isUtc: true));
        ParticipantMethod()
            .checkIfParticipantExists(competitionId: id, participantId: userId)
            .then((isParticipant) {});
      });
      userCompetitions = [];
      ParticipantMethod()
          .getCompetitionParticipants(competitionId: id)
          .then((participants) {
        // participants
        //     .sort((a, b) => a["cumulativePoints"].compareTo(b["cumulativePoints"]));
        participants.sort((a, b) =>
            (b?['cumulativePoints']).compareTo(a?['cumulativePoints']));
        int i = 1;
        participants.forEach((participant) {
          if (participant["userId"] == userId) {
            participant["username"] += " (You)";
            participant["isMe"] = true;
          } else {
            participant["isMe"] == false;
          }
          participant["rank"] = i;
          i += 1;
          userCompetitions.add(ParticipantContainer(participant: participant));
        });
        // userCompetitions.sort((a, b) => (b?['cumulativePoints']).compareTo(a?['cumulativePoints']))
      });
    });
  }

  @override
  void dispose() {
    currTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    id = routeArgs['competitionId'].toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rankings"),
      ),
      body: isLoading
          ? const Loader(title: "Retrieving competition info")
          : Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          _competition?["competitionName"] ?? "Loading...",
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Ends in: $countdown",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      if (userCompetitions.isNotEmpty)
                        Container(
                          height: 500,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: userCompetitions,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class ParticipantContainer extends StatelessWidget {
  const ParticipantContainer({Key? key, required this.participant})
      : super(key: key);

  final dynamic participant;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Card(
          // color: participant.isMe ?? Colors.red : Colors.white,
          color: participant["isMe"] ?? false
              ? const Color.fromARGB(255, 14, 157, 18)
              : Colors.white,
          // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Align(
                  widthFactor: BorderSide.strokeAlignOutside,
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      participant["rank"].toString(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: participant["isMe"] ?? false
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        participant["username"],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: participant["isMe"] ?? false
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const SizedBox(height: 8.0),
                      Text(
                        "Points: " + participant["cumulativePoints"].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: participant["isMe"] ?? false
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
