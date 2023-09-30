import 'package:flutter/material.dart';

class CurrentContestPage extends StatelessWidget {
  const CurrentContestPage({super.key});


  // get the competition details

  // check if user is a participant

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final id = routeArgs['competitionId'].toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Contest"),
      ),
      body: Center(
        child: Text("Id: $id"),
      ),
    );
  }
}
