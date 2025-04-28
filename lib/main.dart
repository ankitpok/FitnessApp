import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/auth/optscreen.dart';
import 'package:fitness_app/auth/phoneauth.dart';
import 'package:fitness_app/pages/exerciseentry.dart';
import 'package:fitness_app/pages/homepage.dart';
import 'package:fitness_app/pages/loginpage.dart';
import 'package:fitness_app/pages/viewworkouts.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData(brightness: Brightness.dark),
      routes: {
        "/": (context) => HomePage(),
        '/login': (context) => PhoneAuth(),
        '/enterworkout': (context) => WorkoutEntry(),
        '/viewworkout': (context) => Viewworkouts(),
        //'/otpscreen': (context) => OTPScreen(verificationid,),
      },
    );
  }
}
