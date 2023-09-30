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
      // print(data);
      DatabaseReference ref = setDatabaseReference(collection);

      await ref.push().set(data);
    } catch (e) {
      print(e);
    }
  }

// ================== get all documents of a specific entity==================
  Future<Object?> getAllDocuments({required String entityName}) async {
    try {
      DatabaseReference ref = setDatabaseReference(entityName);
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        // print(snapshot.value);
        return snapshot.value;
      } else {
        print('No data available.');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

// ================== get a document by id==================
  Future<Object?> getDocumentById(
      {required String entityName, required String id}) async {
    try {
      DatabaseReference ref = setDatabaseReference("$entityName/$id");
      DataSnapshot snapshot = await ref.get();
      if (snapshot.exists) {
        // print(snapshot.value);
        return snapshot.value;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

// ============= get a document by a field; returns a list of documents =============
  Future<Object?> getDocumentByField(
      {required String entityName,
      required String fieldName,
      required String fieldValue}) async {
    try {
      DatabaseReference ref = setDatabaseReference(entityName);
      DataSnapshot snapshot =
          await ref.orderByChild(fieldName).equalTo(fieldValue).get();
      if (snapshot.exists) {
        // print(snapshot.value);
        return snapshot.value;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

// ============= create a record but reuse the Id (from elsewhere)=============
  Future<void> createDocumentWithExistingId(
      {required String collection,
      required String id,
      required Map<String, Object> data}) async {
    try {
      // print(data);
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
      DatabaseReference ref = db.ref(collection);
      // key:value
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
