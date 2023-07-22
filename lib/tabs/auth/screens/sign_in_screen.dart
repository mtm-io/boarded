import 'package:boarded/core/common/google_auth_button.dart';
import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Transform.rotate(
              angle: 0.08,
              child: Image.asset(Constants.logo),
            ),
            SizedBox(
              height: 30,
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
            Stack(
              children: [
                // Add any other widgets you want to display here
                Container(
                  color: Colors.blue, // Change the color to whatever you want
                  height: 300, // Full screen height
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor:
                          1, // Adjust this value to control the visible portion of the container
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        height:
                            100, // Adjust this height to control the height of the clipped container

                        // Change the color to whatever you want
                        child: Center(
                          child: Text(
                            'Bottom Hidden Container',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
