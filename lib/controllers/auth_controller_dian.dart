import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthControllerNadhif with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  // REGISTER
  Future<String?> registerDian({
    required String email,
    required String password,
    required String username,
  }) async {
    if (!email.endsWith("@student.univ.ac.id")) {
      return "Email harus menggunakan domain @student.univ.ac.id";
    }

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Simpan ke Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(cred.user!.uid)
          .set({
        "uid": cred.user!.uid,
        "email": email,
        "username": username,
        "balance": 0,
        "created at": Timestamp.now(),
      });

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  
  // LOGIN
  
  Future<String?> loginDian({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // -----------------------------
  // LOGOUT
  // -----------------------------
  Future<void> logoutDian() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
