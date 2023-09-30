import "./database.dart";

class CompetitionMethods {
  // get all competitions
  Future<Object?> getAllCompetitions() async {
    return Database().getAllDocuments(entityName: "competitions");
  }

  // get competitionById
  Future<Object?> getCompetitionById(String competitionId) async {
    return Database()
        .getDocumentById(entityName: "competitions", id: competitionId);
  }


}
