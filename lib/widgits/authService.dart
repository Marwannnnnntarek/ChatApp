

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser(String? email, String? password) async {
    if (email == null || password == null) {
      throw FirebaseAuthException(code: 'invalid-input');
    }
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logInUser(String? email, String? password) async {
    if (email == null || password == null) {
      throw FirebaseAuthException(code: 'invalid-input');
    }
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
