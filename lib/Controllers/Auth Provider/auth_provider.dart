import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loginAccount(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
         await saveUserLoggedIn();

    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      throw Exception("Something went wrong");
    }
  }

  Future<UserCredential> signUpAccount(String email, String password) async {
    try {
      final UserCredential cred =
          await auth.createUserWithEmailAndPassword(email: email, password: password);            
      return cred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      throw Exception("Something went wrong");
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> checkUserLogin() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool('isLoggedIn') ?? false;
  }

  Future<void> saveUserLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool('isLoggedIn', true);
    notifyListeners();
  }
}
