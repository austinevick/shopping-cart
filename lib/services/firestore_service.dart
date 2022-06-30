import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppy/model/product_model.dart';
import '../model/user.dart';
import 'authentication_service.dart';

final firestoreProvider = Provider((ref) => FirestoreService());

class FirestoreService {
  final _db = FirebaseFirestore.instance;
  final auth = AuthenticationService();

  Future<void> addProducts(ProductModel products) async {
    await _db.collection('products').add(products.toMap());
  }

  Future<void> saveUserInfo(UserModel user) async {
    return await _db.collection('users').doc(user.id).set(user.toMap());
  }

  Future<UserModel> getUserInfo() async {
    var userModel = UserModel();
    final user = await _db.collection('users').get();
    final data = user.docs
        .where((element) => element.id == auth.currentUser!.uid)
        .map((e) => UserModel.fromMap(e.data()))
        .toList();
    for (var item in data) {
      userModel = item;
    }
    return userModel;
  }
}
