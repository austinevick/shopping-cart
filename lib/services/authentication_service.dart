import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppy/model/user.dart';
import 'package:shoppy/services/firestore_service.dart';

class AuthenticationService {
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get auth => _auth.authStateChanges();

  Future<User?> login(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  Future<User?> signup(String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  Future<void> signout() async {
    return _auth.signOut();
  }
}
