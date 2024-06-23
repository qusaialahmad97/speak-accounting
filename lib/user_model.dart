import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? displayName;
  String? email;
  String? photoURL;

  UserModel({this.uid, this.displayName, this.email, this.photoURL});

  // Constructor from Firestore document snapshot
  UserModel.fromFirestore(DocumentSnapshot snapshot) {
    uid = snapshot.id;
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    displayName = data['displayName'];
    email = data['email'];
    photoURL = data['photoURL'];
  }

  // Convert to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
    };
  }
}