import 'package:boarded/core/common/snackbars.dart';
import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/core/constants/firebase_constants.dart';
import 'package:boarded/core/failure.dart';
import 'package:boarded/core/providers/firebase_providers.dart';
import 'package:boarded/core/type_defs.dart';
import 'package:boarded/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
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

  CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);

  /// Function to signout a user
  ///
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> get currentUserState async {
    return _auth.currentUser;
  }

  /// A Stream that says if a user
  /// logged in or not
  ///
  Stream<User?> get authStateChange {
    return _auth.idTokenChanges();
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
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
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

  FutureEither<UserModel> signInWithGoogle() async {
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
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: userCredential.user!.displayName ?? 'Untitled',
          email: userCredential.user!.email ?? 'Anon',
          profilePic: userCredential.user!.photoURL ?? Constants.defaultPfp,
          uid: userCredential.user!.uid,
          isAuthenticated: 'true',
          hostedRooms: [],
          joinedRooms: [],
        );
        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
