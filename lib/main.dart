import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/auth/google_auth.dart';
import 'package:fitness_app/auth/phoneauth.dart';
import 'package:fitness_app/pages/exerciseentry.dart';
import 'package:fitness_app/pages/homepage.dart';
import 'package:fitness_app/pages/login_ini.dart';
import 'package:fitness_app/pages/viewworkouts.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData(brightness: Brightness.dark),
      routes: {
        "/": (context) => HomePage(),
        //'/login': (context) => PhoneAuth(),
        '/login': (context) => LoginScreen(),
        '/login_phone': (context) => PhoneAuth(),
        //'/login_google': (context) => AuthService(),
        '/enterworkout': (context) => WorkoutEntry(),
        '/viewworkout': (context) => ViewWorkouts(),
        //'/otpscreen': (context) => OTPScreen(verificationid,),
      },
    );
  }
}
