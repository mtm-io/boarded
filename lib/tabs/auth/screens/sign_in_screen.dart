import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 69.h,
              left: 29.w,
              right: 3.w,
              bottom: 34.26.h,
            ),
            child: Transform.rotate(
              angle: -0.0274016693,
              child: SvgPicture.asset(
                Constants.logo,
                height: 276.h,
                width: 351.w,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 39.w, bottom: 63.4.h),
            child: const Text(
              "New friends,\nfavourite games",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Transform.rotate(
                      angle: 0,
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 17.17.w,
                            right: 17.17.w,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: const GradientBoxBorder(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.black,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(23.r),
                              ),
                              color: Colors.black,
                            ),
                            height: 340.4.h,
                            width: 348.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 18.w,
                                      top: 14.h,
                                    ),
                                    child: SvgPicture.asset(
                                      Constants.apple,
                                      height: 23.h,
                                      width: 22.11.w,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 111.w,
                                      top: 16.h,
                                    ),
                                    child: Text(
                                      'Continue with Apple ↗',
                                      style: TextStyle(fontSize: 17.sp),
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
                          left: 21.w,
                          right: 21.w,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(23.r),
                            ),
                            color: Colors.black,
                            border: const GradientBoxBorder(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.black,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              width: 1,
                            ),
                          ),
                          height: 270.8
                              .h, // Adjust this height to control the height of the clipped container
                          width: 348.w,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 18.w,
                                    top: 19.h,
                                  ),
                                  child: SvgPicture.asset(
                                    Constants.google,
                                    height: 19.77.h,
                                    width: 22.w,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 100.w,
                                    top: 16.h,
                                  ),
                                  child: Text(
                                    'Continue with Google ↗',
                                    style: TextStyle(fontSize: 17.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 38.h),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          'By continuing, you agree to our ',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color.fromRGBO(109, 109, 109, 1),
                          ),
                        ),
                        Text(
                          'Terms ',
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        Text(
                          'and',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color.fromRGBO(109, 109, 109, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 21.h),
                    child: Text(
                      '\nPrivacy Policy',
                      style: TextStyle(
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
