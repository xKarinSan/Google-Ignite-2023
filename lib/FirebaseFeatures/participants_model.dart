import "package:firebase_database/firebase_database.dart";

import "./database.dart";

class ParticipantMethod {
  Future<void> createParticipant({required String competitionId, required String userId}) async {
    try {
      DatabaseReference ref = Database().setDatabaseReference("participant");

      await ref.push().set({
        "competitionId": competitionId,
        "userId": userId,
        "cumulativePoints":0
      });
    } catch (e) {
      print(e);
    }
  }

  // get all participants of a competition
  Future<List> getAllParticipants() async {
    return Database().getAllDocumentsList(entityName: "competitions");
  }

  // get participant by Id
  Future<Object?> getPartcipants(String participantId) async {
    return Database()
        .getDocumentById(entityName: "participants", id: participantId);
  }

  // get all participants of a competition
  Future<Object?> getCompetitionParticipants(String competitionId) async {
    return Database().getDocumentByField(
        entityName: "competitions",
        fieldName: "userId",
        fieldValue: competitionId);
  }
}
