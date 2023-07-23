import 'package:boarded/core/common/google_auth_button.dart';
import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/gradient_borders.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  void signInWithGoogle(WidgetRef ref) =>
      ref.read(authControllerProvider).signInWithGoogle();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 110,
            ),
            Transform.rotate(
              angle: 0.08,
              child: Image.asset(Constants.logo),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment(-0.7, 0),
              child: Container(
                child: Text(
                  "New friends,\nfavourite games",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(height: 100),
            Expanded(
              child: Stack(
                children: [
                  // Add any other widgets you want to display here
                  GestureDetector(
                    onTap: () {},
                    child: Transform.rotate(
                      angle: 0.0,
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 50.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: GradientBoxBorder(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.black,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Colors.black,
                            ),
                            height: double.infinity,
                            width: 480,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 19,
                                  ),
                                  child: Align(
                                    alignment: Alignment(1, -0.9),
                                    child: Image.asset(
                                      Constants.apple,
                                      scale: 0.7,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 120),
                                  child: Align(
                                    alignment: Alignment(1, -0.91),
                                    child: Text(
                                      'Continue with Apple ↗',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () => signInWithGoogle(ref),
                    child: Transform.rotate(
                      angle: 0.0,
                      child: Padding(
                        padding: EdgeInsets.only(top: 120),
                        child: Align(
                          alignment: Alignment(0, 0.2),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Colors.black,
                              border: GradientBoxBorder(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.black,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                width: 2,
                              ),
                            ),
                            height: double
                                .infinity, // Adjust this height to control the height of the clipped container
                            width: 490,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 19,
                                  ),
                                  child: Align(
                                    alignment: Alignment(1, -0.9),
                                    child: Image.asset(
                                      Constants.google,
                                      scale: 0.7,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 120),
                                  child: Align(
                                    alignment: Alignment(1, -0.91),
                                    child: Text(
                                      'Continue with Google ↗',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
