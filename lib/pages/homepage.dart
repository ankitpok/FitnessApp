import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/pages/exerciseentry.dart';
import 'package:fitness_app/pages/viewworkouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                // User is signed in → Sign out
                await FirebaseAuth.instance.signOut();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Logged out")));
                setState(() {});
              } else {
                // User is not signed in → Go to login screen
                Navigator.pushNamed(context, '/login');
                setState(() {});
              }
            },
            icon: Icon(Icons.login_sharp),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          'Homepage',
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        ).animate().fadeIn(duration: 600.ms),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 253, 253),
              Color.fromARGB(255, 201, 197, 203),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                user != null
                    ? Text(
                          "Welcome ${user.displayName}",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        )
                        .animate()
                        .fade(duration: 800.ms)
                        .scale(delay: 20.ms, duration: 300.ms)
                    : SizedBox(),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => WorkoutEntry(),
                      transition: Transition.circularReveal,
                      duration: Duration(seconds: 1),
                    );
                    //Navigator.pushNamed(context, '/enterworkout');
                  },
                  child: Card(
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: const Color.fromARGB(255, 0, 0, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: AssetImage(
                                'lib/assets/exercise_entry.webp',
                              ),
                              height: 100,
                              width: 100,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            child: Center(
                              child: Container(
                                height: 100,
                                width: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),

                          // Text and other content on the right
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Enter Workout",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.add_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Add Details",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => ViewWorkouts(),
                      transition: Transition.fadeIn,
                      duration: Duration(seconds: 1),
                    );
                    //Navigator.pushNamed(context, '/viewworkout');
                  },
                  child: Card(
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: const Color.fromARGB(255, 0, 0, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          // Image on the left
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // For rounded corners
                            child: Image(
                              image: AssetImage('lib/assets/viewworkouts.webp'),
                              height: 100,
                              width: 100,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            child: Center(
                              child: Container(
                                height: 100,
                                width: 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),

                          // Text and other content on the right
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "View Workout",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.view_array,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "View Workout",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
