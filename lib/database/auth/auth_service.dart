import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecom_app_admin/database/firebase_db_helper.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<bool> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return FirebaseDbHelper.isAdmin(credential.user!.uid);
  }

  static Future<void> logout() async => await _auth.signOut();
}
