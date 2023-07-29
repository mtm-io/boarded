import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
            Expanded(
              flex: 4,
              child: Transform.rotate(
                angle: 0.08,
                child: Image.asset(
                  Constants.logo,
                  scale: 0.7,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment(-0.7, 0),
                child: Container(
                  child: Text(
                    "New friends,\nfavourite games",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
            new Spacer(),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Transform.rotate(
                      angle: 0.0,
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 50.0,
                            left: 20,
                            right: 20,
                          ),
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
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(
                                        Constants.apple,
                                      ),
                                    ),
                                  ),
                                ),
                                new Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 12,
                                        ),
                                        child: AutoSizeText(
                                          'Continue with Apple ↗',
                                          maxLines: 2,
                                          minFontSize: 10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
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
                        padding: EdgeInsets.only(
                          top: 100,
                          left: 16,
                          right: 16,
                        ),
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
                            width: double.infinity,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(
                                        Constants.google,
                                      ),
                                    ),
                                  ),
                                ),
                                new Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 12,
                                          right: 42,
                                        ),
                                        child: AutoSizeText(
                                          'Continue with Google ↗',
                                          maxLines: 2,
                                          minFontSize: 10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
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
