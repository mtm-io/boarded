import 'package:boarded/tabs/auth/repository/auth_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

class AuthController {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  void signInWithGoogle() => _authRepository.signInWithGoogle();

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
}
