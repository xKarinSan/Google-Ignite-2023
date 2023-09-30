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
  var competitions = [];
  final DatabaseReference databaseReference =
      Database().setDatabaseReference("competitions");

  @override
  void initState() {
    super.initState();

    // Get all competitions from the database.
    CompetitionMethods().getAllCompetitions().then((value) {
      List<CompetitionSchema> allCompetitions = [];
      // Convert the data to a Map.
      Map<dynamic, dynamic> data = value as Map<dynamic, dynamic>;

      // Loop through the data and add each competition to the list.
      data.forEach((key, value) {
        // Convert the data to a Map.
        Map<dynamic, dynamic> competitionData = value as Map<dynamic, dynamic>;

        // Create a new CompetitionSchema object.
        CompetitionSchema competition = CompetitionSchema(
          competitionId: key,
          competitionName: competitionData["competitionName"],
          startDate: competitionData["startDate"].toString(),
          endDate: competitionData["endDate"].toString(),
        );

        // Add the competition to the list.
        allCompetitions.add(competition);
      });

      // Update the state of the app.
      setState(() {
        competitions = allCompetitions;
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
        // appBar: AppBar(
        //   title: const Text('Home'),
        // ),
        body: Center(
            child: FirebaseAnimatedList(
                query: databaseReference,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map competition = snapshot.value as Map;
                  competition["competitionId"] = snapshot.key;

                  return CompetitionContainer(
                    competition: competition,
                  );
                })),
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

  @override
  void initState() {
    super.initState();

    // Create a new Countdown object.
    _countdown = Countdown(DateTime.fromMillisecondsSinceEpoch(
        widget.competition["endDate"],
        isUtc: true));

    // Start a timer to update the countdown every second.
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown.calculateRemainingTime();
      });
    });
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
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.competition["competitionName"],
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              const SizedBox(height: 8.0),
                              Text(
                                "Ending in: " + countdown,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                        Align(
                          widthFactor: BorderSide.strokeAlignOutside,
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    )))));
  }
}
