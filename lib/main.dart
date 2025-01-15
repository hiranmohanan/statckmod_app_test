import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:statckmod_app/feature/auth%20login/provider/auth_login_provider.dart';
import 'package:statckmod_app/feature/auth%20login/view/auth_login_view.dart';
import 'package:statckmod_app/feature/auth%20signup/view/auth_signup_view.dart';
import 'package:statckmod_app/feature/home/view/home_view.dart';
import 'package:statckmod_app/feature/splash/view/splash_view.dart';

import 'feature/auth registraction/provider/auth_profile_reg_provider.dart';
import 'feature/auth registraction/view/auth_profile_reg.dart';
import 'feature/auth signup/provider/auth_signup_provider.dart';
import 'feature/home/provider/home_provider.dart';
import 'feature/splash/provider/splash_provider.dart';
import 'firebase_options.dart';
import 'utl/utl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // Theme provider for handeling theme.
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SplashProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AuthSignupProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AuthProfileRegProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AuthLoginProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeProvider(),
          ),
        ],
        builder: (context, child) {
          return Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              // used a theme package for color theme.
              theme: FlexThemeData.light(scheme: FlexScheme.bahamaBlue),
              // For dark theme.
              darkTheme: FlexThemeData.dark(scheme: FlexScheme.bahamaBlue),
              // Use dark or light theme based on system setting.

              themeMode: context.watch<ThemeProvider>().themeMode,
              initialRoute: '/',
              routes: {
                '/': (context) => Consumer<SplashProvider>(
                        builder: (context, provider, child) {
                      return provider.isInitialized
                          ? provider.isLoggedIn
                              ? const HomeView()
                              : const AuthLoginView()
                          : provider.isProfileReg
                              ? const AuthProfileReg()
                              : const SplashView();
                    }),
                '/login': (context) => const AuthLoginView(),
                '/signup': (context) => const AuthSignupView(),
                '/profile': (context) => const AuthProfileReg(),
                '/home': (context) => const HomeView(),
              },
            );
          });
        });
  }
}
