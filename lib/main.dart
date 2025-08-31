import 'package:flutter/material.dart';
import 'package:saabi/screens/splash_screen.dart';
import 'onboarding/onboarding.dart';
import 'screens/createaccount.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saabbi',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/create-account': (context) => const CreateAccountPage(),
      },
    );
  }
}