import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BadgeService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _badgeCollection = FirebaseFirestore.instance.collection('badges');

  Future<void> earnBadge(String badgeId) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      await _badgeCollection.add({
        'userId': user.uid,
        'badgeId': badgeId,
        'earnedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<QuerySnapshot> getUserBadges() {
    final User? user = _auth.currentUser;
    return _badgeCollection.where('userId', isEqualTo: user?.uid).snapshots();
  }
}
