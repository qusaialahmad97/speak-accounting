import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FollowService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _followCollection = FirebaseFirestore.instance.collection('follows');

  Future<void> followUser(String followeeId) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      await _followCollection.add({
        'followerId': user.uid,
        'followeeId': followeeId,
      });
    }
  }

  Stream<QuerySnapshot> getFollowedUsers() {
    final User? user = _auth.currentUser;
    return _followCollection.where('followerId', isEqualTo: user?.uid).snapshots();
  }
}
