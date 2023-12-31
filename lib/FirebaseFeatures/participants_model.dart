import "package:firebase_database/firebase_database.dart";
import "package:googleignite2023/FirebaseFeatures/competition_model.dart";
import "./user_model.dart";
import "./database.dart";

class ParticipantMethod {
  Future<void> createParticipant(
      {required String competitionId, required String userId}) async {
    try {
      DatabaseReference ref = Database().setDatabaseReference("participant");

      await ref.push().set({
        "competitionId": competitionId,
        "userId": userId,
        "cumulativePoints": 0
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Map<dynamic, dynamic>> getRandomParticipatingCompetition(
      {required String userId}) async {
    Map<dynamic, dynamic> competitionsMap =
        await CompetitionMethods().getAllCompetitionsMap();
    Map<dynamic, dynamic> participantMap = await Database()
        .getDocumentByFieldMap(
            entityName: "participant", fieldName: "userId", fieldValue: userId);
    List res = [];
    participantMap.forEach((key, value) {
      Map<dynamic, dynamic> competition =
          competitionsMap[value["competitionId"]];
      res.add(competition);
    });
    return res.isNotEmpty ? res[0] : {};
  }

  Future<List> getParticipatingCompetition({
    required String userId,
  }) async {
    Map<dynamic, dynamic> competitionsMap =
        await CompetitionMethods().getAllCompetitionsMap();
    Map<dynamic, dynamic> participantMap = await Database()
        .getDocumentByFieldMap(
            entityName: "participant", fieldName: "userId", fieldValue: userId);
    List res = [];
    participantMap.forEach((key, value) {
      print(value);
      Map<dynamic, dynamic> competition =
          competitionsMap[value["competitionId"]];
      res.add(value);
    });
    return res;
  }

  // get all participants of a competition
  Future<List> getCompetitionParticipants(
      {required String competitionId}) async {
    // get all users from db
    Map<dynamic, dynamic> userMap = await UserMethods().getAllUsersMap();
    Map<dynamic, dynamic> participantMap = await Database()
        .getDocumentByFieldMap(
            entityName: "participant",
            fieldName: "competitionId",
            fieldValue: competitionId);
    // get all participant records from db
    List res = [];
    participantMap.forEach((key, value) {
      Map<dynamic, dynamic> user = userMap[value["userId"]];
      value["username"] = user["username"];
      res.add(value);
    });
    return res;
  }

  // check if participant is inside a competition
  Future<bool> checkIfParticipantExists(
      {required String competitionId, required String participantId}) async {
    // check
    bool res = false;
    Map<dynamic, dynamic> participantMap = await Database()
        .getDocumentByFieldMap(
            entityName: "participant",
            fieldName: "competitionId",
            fieldValue: competitionId);
    // get all participant records from db
    participantMap.forEach((key, value) {
      if (value["userId"] == participantId) {
        res = true;
        return;
      }
    });
    return res;
  }
}
