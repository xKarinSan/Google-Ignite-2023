
import "./database.dart";

class CompetitionMethods {
  // get all competitions
  Future<List> getAllCompetitionsList() async {
    return Database().getAllDocumentsList(entityName: "competitions");
  }

  Future<Map<dynamic, dynamic>> getAllCompetitionsMap() async {
    return Database().getAllDocumentsMap(entityName: "competitions");
  }

  // get competition by Id
  Future<Map<dynamic, dynamic>> getCompetitionById(String competitionId) async {
    return Database()
        .getDocumentById(entityName: "competitions", id: competitionId);
  }
}
