import 'package:boarded/core/common/loader.dart';
import 'package:boarded/router.dart';
import 'package:boarded/tabs/auth/controller/auth_controller.dart';
import 'package:boarded/utils/pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Subscription to a authStateChange Stream
    /// from AuthRepository
    final authStateStream = ref.watch(authStateChangeProvider);

    /// handling of authStateChange Stream
    return authStateStream.when(
      /// data is a User class
      /// that is present when the user is logged in
      data: (data) {
        return ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (context, child) => MaterialApp.router(
            theme: Pallete.darkTheme,
            debugShowCheckedModeBanner: false,

            /// when data is null it means that there is no logged in user
            /// opposite data != null => user is logged in
            /// p.s. check class AppRouter in roter.dart

            routerConfig: AppRouter(isAuth: data != null ? true : false).router,
          ),
        );
      },

      /// error when the Stream returns an error
      error: (error, stackTrace) => Text(error.toString()),

      /// loading when the Stream in process
      loading: () =>
          const Loader(), // Loader is a custom Widget in folder common
    );
  }
}
