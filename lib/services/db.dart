import 'package:LaFoodie/Menu%20Screen/Data.dart';
import 'package:LaFoodie/Menu%20Screen/Data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference collection = Firestore.instance.collection('users');

  Future<void> updateUserData(String email) async {
    return await collection.document(uid).setData({
      'email': email,
    });
  }

  Future<void> storeUserData(
      int id, String date, String time, int people) async {
    return await collection.document(uid).collection("reservations").add({
      'id': id,
      'date': date,
      'time': time,
      'people': people,
    });
  }

  List<UserDetails> detailsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return UserDetails(
          id: doc.data['id'] ?? 0,
          date: doc.data['date'] ?? '0',
          time: doc.data['time'] ?? '0',
          people: doc.data['people'] ?? 0);
    }).toList();
  }

  // get brews stream
  Stream<List<UserDetails>> get users {
    return collection
        .document(uid)
        .collection('reservations')
        .snapshots()
        .map(detailsFromSnapshot);
  }
}
