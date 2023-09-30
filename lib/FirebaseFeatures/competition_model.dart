import "./database.dart";

class CompetitionMethods {
  // get all competitions
  Future<List> getAllCompetitions() async {
    return Database().getAllDocumentsList(entityName: "competitions");
  }

  // get competition by Id
  Future<Map<dynamic, dynamic>> getCompetitionById(String competitionId) async {
    return Database()
        .getDocumentById(entityName: "competitions", id: competitionId);
  }
}
