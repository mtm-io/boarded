import 'package:boarded/core/common/snackbars.dart';
import 'package:boarded/core/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

/// Constructor
class AuthRepository {
  // ignore: unused_field
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  /// Function to signout a user
  ///
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// A Stream that says if a user
  /// logged in or not
  ///
  Stream<User?> get authStateChange {
    return _auth.authStateChanges();
  }

  /// Email + Password Sing Up ///
  ///
  ///
  ///
  Future<void> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) async {
    try {
      /// credential has all information about current user

      // ignore: unused_local_variable
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      showErrorSnackBar(context, e.message!);
    }
  }

  /// Email + Password Sing In ///
  ///
  ///
  ///
  ///
  Future<void> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // ignore: unused_local_variable
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      showErrorSnackBar(context, e.message!);
    }
  }

  /// Google Auth ///
  ///
  ///
  ///
  ///

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      /// userCredential has information
      /// about Google Account of loggedin User
      /// for ex. userCredential.user?.email gives
      /// as his email. Here are all Properties of user Class:
      /// https://pub.dev/documentation/firebase/latest/firebase/User-class.html
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // ignore: avoid_print
      print(userCredential.user?.email); // just for testing
    } catch (e) {}
  }
}
