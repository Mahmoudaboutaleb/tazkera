// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tazkera/features/Models/user_models.dart';
import 'package:tazkera/firebase_options.dart';

class FirebaseService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static UserModels? _currentUser;
  static UserModels? get currentUser => _currentUser;

  static Future<void> setupFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<bool> signUp({
    required String username,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final UserModels user = UserModels(
        email: email,
        name: name,
        id: cred.user!.uid,
        image: '',
      );

      final docRef = firestore.collection('users').doc(cred.user!.uid);
      final doc = await docRef.get();
      if (doc.exists) {
        return false; // User already exists
      }

      await docRef.set(user.toJson());
      _currentUser = user;
      return true;
    } catch (e) {
      print('Error during sign up: $e');
      return false;
    }
  }

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (cred.user != null) {
        final doc =
            await firestore.collection('users').doc(cred.user!.uid).get();
        final data = doc.data();
        if (data != null) {
          _currentUser = UserModels.fromJson(data);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', email);
          await prefs.setString('password', password);
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  static Future<void> logout() async {
    await auth.signOut();
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserStream() {
    return firestore.collection('users').snapshots();
  }
}
