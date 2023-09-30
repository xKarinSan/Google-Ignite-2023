import "./database.dart";

class ParticipantMethod {
  // get all participants of a competition
  Future<Object?> getAllParticipants() async {
    return Database().getAllDocuments(entityName: "competitions");
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
