import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  Future updateUserData(String fullname, String email) async {
    return await userCollection.doc(uid).set({
      "fullname": fullname,
      "email": email,
      "groups": [],
      "profilepic": "",
      "uid": uid,
    });
  }
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where("email",isEqualTo: email).get();
    return snapshot;
  }
}
