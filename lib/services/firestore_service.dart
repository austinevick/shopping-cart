import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<DocumentReference> saveUserInfo(UserModel user) async {
    return await _db.collection('users').add(user.toMap());
  }
}
