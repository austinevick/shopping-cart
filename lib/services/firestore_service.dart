import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppy/model/product_model.dart';
import '../model/user.dart';
import 'authentication_service.dart';

final firestoreProvider = Provider((ref) => FirestoreService());

class FirestoreService {
  final _usersCollection = FirebaseFirestore.instance.collection('users');
  final _productCollection = FirebaseFirestore.instance.collection('products');
  final _cartCollection = FirebaseFirestore.instance.collection('carts');
  final _auth = AuthenticationService();

  Future<void> addProducts(ProductModel products) async =>
      await _productCollection.add(products.toMap());

  Future<List<ProductModel>> getProducts() async {
    final products = await _productCollection.get();
    return products.docs.map((e) => ProductModel.fromMap(e.data())).toList();
  }

  bool isAlreadyInCart(int id) {
    return true;
  }

  Future<void> removeProductFromCart(ProductModel item) async {}

//  num getTotalPriceInCart() {
//     return carts.fold<num>(
//         0, (previousValue, element) => previousValue + element.price!);
//   }

  Future<void> addProductsToCart(ProductModel products) async =>
      await _cartCollection.doc(_auth.currentUser!.uid).set(products.toMap());

  Future<List<ProductModel>> getProductsFromCart() async {
    final products = await _cartCollection.get();
    return products.docs.map((e) => ProductModel.fromMap(e.data())).toList();
  }

  Future<void> saveUserInfo(UserModel user) async =>
      await _usersCollection.doc(user.id).set(user.toMap());

  Future<UserModel> getUserInfo() async {
    var userModel = UserModel();
    final user = await _usersCollection.get();
    final data = user.docs
        .where((element) => element.id == _auth.currentUser!.uid)
        .map((e) => UserModel.fromMap(e.data()))
        .toList();
    for (var item in data) {
      userModel = item;
    }
    return userModel;
  }
}
