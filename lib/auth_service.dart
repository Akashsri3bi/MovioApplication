import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:movies/user.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Users? _userFromFirebaseAuth(auth.User? user) {
    if (user == null) {
      return null;
    } else {
      return Users(user.uid, user.email);
    }
  }

  Stream<Users?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseAuth);
  }

  Future<Users?> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebaseAuth(credential.user);
  }

  Future<Users?> createUserWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebaseAuth(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
