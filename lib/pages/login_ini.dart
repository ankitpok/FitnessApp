import 'package:fitness_app/auth/google_auth.dart';
import 'package:fitness_app/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Login to continue',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 40),

              // Phone Login Button
              // LoginButton(
              //   text: 'Login with Phone',
              //   icon: Icons.phone,
              //   color: Colors.blueGrey,
              //   onPressed: () {
              //     Navigator.pushNamed(context, "/login_phone");
              //   },
              // ),
              SizedBox(height: 20),

              // Google Login Button
              LoginButton(
                text: 'Login with Google',
                icon: FontAwesomeIcons.google,
                color: Colors.redAccent,
                onPressed: () async {
                  try {
                    final userCredential =
                        await AuthService().signInWithGoogle();
                    if (userCredential != null) {
                      // User successfully signed in
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  } catch (e) {
                    print('Error signing in: $e');
                    // Optionally show a snackbar or alert
                  }
                },
              ),

              Spacer(),
              Text(
                'By continuing, you agree to our Terms & Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const LoginButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: color,
        elevation: 4,
      ),
      icon: Icon(icon, size: 20, color: Colors.white),
      label: Text(text, style: TextStyle(fontSize: 16, color: Colors.white)),
      onPressed: onPressed,
    );
  }
}
