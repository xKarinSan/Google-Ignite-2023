export "database.dart";
import "package:firebase_database/firebase_database.dart";

class Database {
  final FirebaseDatabase db = FirebaseDatabase.instance;

  Future<void> createDocument(
      {required String collection, required Map<String, Object> data}) async {
    try {
      // print(data);
      DatabaseReference ref = db.ref(collection);

      await ref.push().set(data);
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
      DatabaseReference ref = db.ref(collection);
      await ref.remove();
    } catch (e) {
      print(e);
    }
  }
}
