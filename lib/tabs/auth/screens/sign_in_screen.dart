import 'dart:async';
import 'package:boarded/core/common/loader.dart';
import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/core/constants/my_text.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:boarded/utils/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:sensors_plus/sensors_plus.dart';

void signInWithGoogle(BuildContext context, WidgetRef ref) =>
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  double me2 = 0; //  -1 < me2 < 1

  late StreamSubscription streamSub;

  @override
  void initState() {
    super.initState();
    streamSub = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        var me = event.z;

        me2 = num.parse(me.toStringAsFixed(2)).toDouble();
      });
    });
  }

  @override
  void dispose() {
    streamSub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 69.h, left: 29.w, right: 14.w, bottom: 34.26.h),
                    child: Transform.rotate(
                      angle: -0.0274016693,
                      child: SvgPicture.asset(
                        Constants.logo,
                        height: 271.r,
                        width: 351.w,
                        colorFilter: const ColorFilter.mode(
                          Pallete.imageColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 39.w, bottom: 61.4.h, right: 170.w),
                    child: FittedBox(
                      child: MyText(
                        "New friends,\nfavourite games",
                        textAlign: TextAlign.start,
                        maxLines: 2,

                        /// a way of applying Theme
                        /// check out - utils/pallete.dart
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        AnimatedRotation(
                          turns: -(me2 / 140), // basicaly speed of the rotation
                          duration:
                              const Duration(milliseconds: 500), // this too
                          //first card

                          child: const AuthAppleCard(
                            text: 'Continue with Apple ↗',
                            icon: Constants.apple,
                          ),
                        ),
                        AnimatedRotation(
                            turns: me2 / 140,
                            duration: const Duration(milliseconds: 500),
                            // second card
                            child: const AuthGoogleCard(
                              text: "Continue with Google ↗",
                              icon: Constants.google,
                            )),

                        /// Privacy Policy stuff
                        ///
                        AnimatedRotation(
                            turns: -(me2 / 140),
                            duration: const Duration(milliseconds: 500),
                            // second card
                            child: const AuthGitHubCard(
                              text: "Continue with GitHub ↗",
                              icon: Constants.github,
                            )),
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    MyText(
                                      'By continuing, you agree to our ',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: const Color.fromRGBO(
                                            109, 109, 109, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    MyText(
                                      'Terms ',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    MyText(
                                      'and',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: const Color.fromRGBO(
                                            109, 109, 109, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                MyText(
                                  '\nPrivacy Policy',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    height: 0.65,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
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

class AuthAppleCard extends StatelessWidget {
  final String text;
  final String icon;
  const AuthAppleCard({
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Transform.rotate(
        angle: 0, // z / 10 boilerplate code , sry)
        child: Padding(
          padding: EdgeInsets.only(left: 17.17.w, right: 17.17.w),
          child: Container(
            decoration: BoxDecoration(
              border: const GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Pallete.blackColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(23.r),
              ),
              color: Pallete.blackColor,
            ),
            height: 340.4.h,
            width: 348.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 18.w, top: 14.h),
                    child: SvgPicture.asset(
                      icon,
                      height: 22.11.sp,
                      width: 18.sp,
                      colorFilter: const ColorFilter.mode(
                        Pallete.iconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 111.w, top: 16.h),
                    child: MyText(
                      text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthGoogleCard extends ConsumerWidget {
  final String text;
  final String icon;
  const AuthGoogleCard({
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        signInWithGoogle(context, ref);
      },
      child: Transform.rotate(
        angle: 0.0,
        child: Padding(
          padding: EdgeInsets.only(left: 21.w, right: 21.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(23.r),
              ),
              color: Pallete.blackColor,
              border: const GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Pallete.blackColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                width: 1,
              ),
            ),
            height: 269.8
                .h, // Adjust this height to control the height of the clipped container
            width: 348.w,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 18.w, top: 19.h),
                    child: SvgPicture.asset(
                      icon,
                      height: 19.77.sp,
                      width: 22.sp,
                      colorFilter: const ColorFilter.mode(
                        Pallete.iconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 100.w, top: 16.h),
                    child: MyText(
                      text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthGitHubCard extends ConsumerWidget {
  final String text;
  final String icon;
  const AuthGitHubCard({
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        signInWithGoogle(context, ref);
      },
      child: Transform.rotate(
        angle: 0.0,
        child: Padding(
          padding: EdgeInsets.only(left: 21.w, right: 21.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(23.r),
              ),
              color: Pallete.blackColor,
              border: const GradientBoxBorder(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Pallete.blackColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                width: 1,
              ),
            ),
            height: 160
                .h
                .h, // Adjust this height to control the height of the clipped container
            width: 348.w,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 18.w, top: 19.h),
                    child: SvgPicture.asset(
                      icon,
                      height: 19.77.sp,
                      width: 22.sp,
                      colorFilter: const ColorFilter.mode(
                        Pallete.iconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 100.w, top: 16.h),
                    child: MyText(
                      text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
