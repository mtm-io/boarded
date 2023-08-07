import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:boarded/utils/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// just a Google Auth Button
class SignInButton extends ConsumerWidget {
  const SignInButton({Key? key}) : super(key: key);

  /// reads value from authControllerProvider
  /// that is actually a AuthController class and provides
  /// signInWithGoogle function
  void signInWithGoogle(BuildContext context, WidgetRef ref) =>
      ref.read(authControllerProvider.notifier).signInWithGoogle(context);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        onPressed: () => signInWithGoogle(context, ref),
        icon: Image.asset(
          Constants.google,
          width: 60,
        ),
        label: const Text(
          'Continue with Google',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.greyColor,
          minimumSize: const Size.fromHeight(70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
