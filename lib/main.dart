import 'package:flutter/material.dart';
import 'package:onboarding_screen/auth_page.dart';
//import 'package:onboarding_screen/screens/onboarding_screen.dart';
//import 'package:onboarding_screen/screens/onboarding_screen.dart';
import 'package:onboarding_screen/sign_in/sign_in.dart';
//import 'components/my_textfield.dart';
//import 'components/my_textbutton.dart';
//import 'components/my_button.dart';
//import 'sign_in/sign_in.dart';
//import 'auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:onboarding_screen/login_sucess_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ON BOARDING SCREEN',
      theme: ThemeData.light(useMaterial3: true),
      //home: const OnBoardingScreen(),
      home: SignInScreen(),
    );
  }
}
