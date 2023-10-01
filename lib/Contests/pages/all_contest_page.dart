import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../General/bottom_bar.dart';
import "package:googleignite2023/FirebaseFeatures/database.dart";
import "../../FirebaseFeatures/competition_model.dart";
import "../helper_functions.dart";
import 'dart:async';

class CompetitionFields {
  final String competitionName;
  final String startDate;
  final String endDate;

  CompetitionFields({
    required this.competitionName,
    required this.startDate,
    required this.endDate,
  });
}

class CompetitionSchema {
  final String competitionId;
  final String competitionName;
  final String startDate;
  final String endDate;

  CompetitionSchema({
    required this.competitionId,
    required this.competitionName,
    required this.startDate,
    required this.endDate,
  });
}

class ContestPage extends StatefulWidget {
  const ContestPage({Key? key}) : super(key: key);

  @override
  State<ContestPage> createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage> {
  List<Widget> competitionWidgets = [];
  final DatabaseReference databaseReference =
      Database().setDatabaseReference("competitions");

  @override
  void initState() {
    super.initState();
    // Get all competitions from the database.
    CompetitionMethods().getAllCompetitions().then((value) {
      List<Widget> tempList = [];
      value.sort((a, b) => (a?['endDate']).compareTo(b?['endDate']));
      value.forEach((competition) {
        tempList.add(CompetitionContainer(
          competition: competition as Map,
        ));
      });

      setState(() {
        competitionWidgets = tempList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(26, 159, 5, 1),
          title: Text(
            "Contests",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: ListView(
            children: competitionWidgets,
          ),
        ),
        bottomNavigationBar: BottomBar());
  }
}

class CompetitionContainer extends StatefulWidget {
  const CompetitionContainer({
    Key? key,
    required this.competition,
  }) : super(key: key);

  final Map competition;

  @override
  State<CompetitionContainer> createState() => _CompetitionContainerState();
}

class _CompetitionContainerState extends State<CompetitionContainer> {
  late Countdown _countdown;
  Timer? currTimer;

  @override
  void initState() {
    super.initState();

    // Create a new Countdown object.
    _countdown = Countdown(DateTime.fromMillisecondsSinceEpoch(
        widget.competition["endDate"],
        isUtc: true));

    // Start a timer to update the countdown every second.
    currTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown.calculateRemainingTime();
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
    String countdown = _countdown.formattedRemainingTime;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/contests/current', arguments: {
          'competitionId': widget.competition["competitionId"].toString(),
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(
                12.0), // Increased padding for better spacing
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.competition["competitionName"],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Ending in: $countdown", // Simplified string concatenation
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 24.0, // Set the icon size
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
