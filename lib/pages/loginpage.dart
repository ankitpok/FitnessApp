import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Welcome",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Enter username",
                    label: Text("Username"),
                  ),
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    label: Text("Password"),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(),
                  child: const Text("Login"),
                ),
                const Text(
                  "Is this working?",
                  style: TextStyle(color: Colors.amberAccent),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(color: Colors.red),
              ),
              const Text("Hi"),
            ],
          ),
        ],
      ),
    );
  }
}
