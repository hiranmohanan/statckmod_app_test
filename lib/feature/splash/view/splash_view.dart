import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statckmod_app/constants/constants.dart';

import '../provider/splash_provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context);

    // Start checking login status when the splash screen is built
    Future.microtask(() => splashProvider.initialize());
    return Scaffold(
      body: Center(
        child: Text(
          Kstrings.loading,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
