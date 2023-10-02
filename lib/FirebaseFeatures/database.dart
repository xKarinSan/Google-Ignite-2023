export "database.dart";
import "package:firebase_database/firebase_database.dart";

class Database {
  final FirebaseDatabase db = FirebaseDatabase.instance;

  // ============= returns a database reference; based on entity and/or also with id =============
  DatabaseReference setDatabaseReference(String collection) {
    return db.ref(collection);
  }

  // ============= create a new document with a new id=============
  Future<void> createDocumentWithNewId(
      {required String collection, required Map<String, Object> data}) async {
    try {
      DatabaseReference ref = setDatabaseReference(collection);

      await ref.push().set(data);
    } catch (e) {
      print(e);
    }
  }

// ================== get all documents of a specific entity==================
  Future<Map<dynamic, dynamic>> getAllDocumentsMap(
      {required String entityName}) async {
    try {
      DatabaseReference ref = setDatabaseReference(entityName);
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        return snapshot.value as Map<dynamic, dynamic>;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<List> getAllDocumentsList({required String entityName}) async {
    try {
      Map<dynamic, dynamic> unprocessedData =
          await getAllDocumentsMap(entityName: entityName);
      List res = [];
      unprocessedData.forEach((key, value) {
        value["id"] = key;
        res.add(value);
      });

      return res;
    } catch (e) {
      return [];
    }
  }

// ================== get a document by id==================
  Future<Map<dynamic, dynamic>> getDocumentById(
      {required String entityName, required String id}) async {
    DatabaseReference ref = setDatabaseReference("$entityName/$id");
    DataSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      data["id"] = id;
      return data;
    } else {
      return {};
    }
  }

// ============= get a document by a field; returns a list of documents =============
  Future<Map<dynamic, dynamic>> getDocumentByFieldMap(
      {required String entityName,
      required String fieldName,
      required String fieldValue}) async {
    try {
      DatabaseReference ref = setDatabaseReference(entityName);
      DataSnapshot snapshot =
          await ref.orderByChild(fieldName).equalTo(fieldValue).get();
      if (snapshot.exists) {
        return snapshot.value as Map<dynamic, dynamic>;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<List> getDocumentByFieldList(
      {required String entityName,
      required String fieldName,
      required String fieldValue}) async {
    try {
      Map<dynamic, dynamic> unprocessedData =
          await getAllDocumentsMap(entityName: entityName);
      List res = [];
      unprocessedData.forEach((key, value) {
        value["id"] = key;
        res.add(value);
      });
      return res;
    } catch (e) {
      return [];
    }
  }

// ============= create a record but reuse the Id (from elsewhere)=============
  Future<void> createDocumentWithExistingId(
      {required String collection,
      required String id,
      required Map<String, Object> data}) async {
    try {
      DatabaseReference ref = setDatabaseReference("$collection/$id");

      await ref.set(data);
    } catch (e) {
      print(e);
    }
  }

// ============= update a record that has a specific ID=============
  Future<void> updateDocument(
      {required String collection,
      required String docId,
      required Map<String, Object> data}) async {
    try {
      DatabaseReference ref = db.ref("$collection+/$docId");
      await ref.update(data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteDocument(
      {required String collection, required String docId}) async {
    try {
      DatabaseReference ref = setDatabaseReference(collection);
      await ref.remove();
    } catch (e) {
      print(e);
    }
  }
}
