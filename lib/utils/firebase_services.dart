import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Authentication methods
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw Exception('Authentication failed: ${error.message}');
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw Exception('Registration failed: ${error.message}');
    }
  }

  // Firestore methods
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      String userId) async {
    final docRef = _firestore.collection('users').doc(userId);
    final snapshot = await docRef.get();
    return snapshot;
  }

  // Add a method to save user information after registration (optional)
  Future<void> saveUserData(String userId, String name, String email,
      String userType, String image) async {
    final docRef = _firestore.collection('users').doc(userId);
    await docRef.set({
      'name': name,
      'email': email,
      'userID': userId,
      'image': image,
    });
  }
}
