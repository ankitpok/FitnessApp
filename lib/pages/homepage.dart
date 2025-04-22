import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Homepage'),
        bottom: PreferredSize(
          preferredSize: Size(7, 7),
          child: Text('Welcome'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/enterworkout');
              },
              child: Text('Enter workout'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/viewworkout');
              },
              child: Text('View workout'),
            ),
          ],
        ),
      ),
    );
  }
}
