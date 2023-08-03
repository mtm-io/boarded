import 'package:boarded/tabs/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:boarded/core/utils.dart';

/// Provider of AuthController class ///
///
///
final authControllerProvider = Provider(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

/// Provides a Stream of AuthStateChanges
///from the AuthRepository
final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.authStateChange;
});

/// AuthController ///
/// provides functions from AuthRepository class
/// with additional logic
///
class AuthController {
  final AuthRepository _authRepository;

  /// Constructor of AuthController
  AuthController({required AuthRepository authRepository}) : _authRepository = authRepository;

  /// Provides SignOut Function
  ///
  void signOut() => _authRepository.signOut();

  ///

  Stream<User?> get authStateChange {
    return _authRepository.authStateChange;
  }

  Future<User?> get currentUserState {
    return _authRepository.currentUserState;
  }

  /// Provides signInWithGoogle() Function
  /// from AuthRepository
  void signInWithGoogle(BuildContext context) async {
    final user = await _authRepository.signInWithGoogle();
    user.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  /// Provides createUserWithEmailAndPassword() Function
  /// from AuthRepository
  void createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) =>
      _authRepository.createUserWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
        context: context,
      );

  /// Provides signInWithEmailAndPassword() Function
  /// from AuthRepository
  ///
  void signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) =>
      _authRepository.signInWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
        context: context,
      );
}
