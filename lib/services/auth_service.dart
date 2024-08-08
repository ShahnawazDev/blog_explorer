import 'package:firebase_auth/firebase_auth.dart';
import 'package:blog_explorer/models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user != null
        ? UserModel(
            id: userCredential.user!.uid, email: userCredential.user!.email!)
        : null;
  }

  Future<UserModel?> signUpWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user != null
        ? UserModel(
            id: userCredential.user!.uid, email: userCredential.user!.email!)
        : null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) =>
        firebaseUser != null
            ? UserModel(id: firebaseUser.uid, email: firebaseUser.email!)
            : null);
  }
}
