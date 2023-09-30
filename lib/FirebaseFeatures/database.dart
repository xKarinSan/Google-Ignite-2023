export "database.dart";
import "package:firebase_database/firebase_database.dart";

class Database {
  final FirebaseDatabase db = FirebaseDatabase.instance;

  DatabaseReference setDatabaseReference(String collection) {
    return db.ref(collection);
  }

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

// will need filtering
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

  Future<void> updateDocument(
      {required String collection,
      required String docId,
      required Map<String, Object> data}) async {
    try {
      DatabaseReference ref = db.ref(collection);
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
