//import 'dart:async';
import 'package:boarded/core/common/loader.dart';
import 'package:boarded/core/constants/constants.dart';
import 'package:boarded/core/constants/my_text.dart';
//import 'package:boarded/router.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
//import 'package:sensors_plus/sensors_plus.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  void signInWithGoogle(BuildContext context, WidgetRef ref) =>
      ref.read(authControllerProvider.notifier).signInWithGoogle(context);

  // final Stream _myStream = gyroscopeEvents;
  // late StreamSubscription _sub;
  // double x = 0;
  // double y = 0;
  // double z = 0;

// @override
// void initState() {
//   super.initState();
//
//   _sub = _myStream.listen(
//     (event) {
//       setState(
//         () {
//           x = event.x;
//           y = event.x;
//           z = event.x;
//         },
//       );
//     },
//     cancelOnError: true,
//   );
// }
//
// @override
// void dispose() {
//   super.dispose();
//
//   _sub.cancel();
// }

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
                      top: 69.h,
                      left: 29.w,
                      right: 14.w,
                      bottom: 34.26.h,
                    ),
                    child: Transform.rotate(
                      angle: -0.0274016693,
                      child: SvgPicture.asset(
                        Constants.logo,
                        height: 271.r,
                        width: 351.w,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 39.w, bottom: 61.4.h, right: 170.w),
                    child: const FittedBox(
                      child: MyText(
                        "New friends,\nfavourite games",
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Transform.rotate(
                            angle: 0, // z / 10 boilerplate code , sry)
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
                                          height: 22.11.sp,
                                          width: 18.sp,
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
                                        child: MyText(
                                          'Continue with Apple ↗',
                                          style: TextStyle(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w700,
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
                        GestureDetector(
                          onTap: () {
                            // showDialogue(context);

                            signInWithGoogle(context, ref);
                            // ref.watch(authControllerProvider.notifier).currentUserState.((user) {
                            //   if (user != null) {
                            //     hideProgressDialogue(context);
                            //   } else {
                            //     print("NO");
                            //   }
                            // });
                          },
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
                                height: 269.8.h, // Adjust this height to control the height of the clipped container
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
                                          height: 19.77.sp,
                                          width: 22.sp,
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
                                        child: MyText(
                                          'Continue with Google ↗',
                                          style: TextStyle(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w700,
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
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 30.sp),
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
                                        color: const Color.fromRGBO(109, 109, 109, 1),
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
                                        color: const Color.fromRGBO(109, 109, 109, 1),
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
