import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);


      await _db.collection('users').doc(result.user!.uid).set({
        'uid': result.user!.uid,
        'email': result.user!.email,
      }, SetOptions(merge: true)); /// override avid

      return result.user;
    } catch (e) {
      print('Login Error: $e');
      return null;
    }
  }

  Future<User?> register(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _db.collection('users').doc(result.user!.uid).set({
        'uid': result.user!.uid,
        'email': result.user!.email,
      });

      return result.user;
    } catch (e) {
      print('Register Error: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
