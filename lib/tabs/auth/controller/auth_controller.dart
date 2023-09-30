import 'package:boarded/models/user_model.dart';
import 'package:boarded/tabs/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:boarded/core/utils.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

/// Provider of AuthController class ///
///
///
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

/// Provides a Stream of AuthStateChanges
///from the AuthRepository
final authStateChangeProvider = StreamProvider((ref) {
  print('create testProvider');
  final authController = ref.watch(authControllerProvider.notifier);
  ref.onDispose(() {
    print('dispose testProvider');
  });
  ref.onResume(() {
    print('resume testProvider');
  });
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

/// AuthController ///
/// provides functions from AuthRepository class
/// with additional logic
///
class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  /// Constructor of AuthController
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  /// Provides SignOut Function
  ///
  void signOut() => _authRepository.signOut();

  ///

  Stream<User?> get authStateChange {
    print(2);
    return _authRepository.authStateChange;
  }

  Future<User?> get currentUserState {
    return _authRepository.currentUserState;
  }

  /// Provides signInWithGoogle() Function
  /// from AuthRepository
  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) => _ref.read(userProvider.notifier).update((state) => userModel),
    );
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

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
