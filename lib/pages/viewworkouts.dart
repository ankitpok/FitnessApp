import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Viewworkouts extends StatelessWidget {
  const Viewworkouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Your Workouts")),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("Exercise Entry").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.size,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text('${snapshot.data?.docs[index]["dayType"]}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Exercise: ${snapshot.data?.docs[index]["exercise"]}',
                        ),
                        Text('Weight: ${snapshot.data?.docs[index]["reps"]}'),
                        Text('Reps: ${snapshot.data?.docs[index]["weight"]}'),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.hasError.toString()));
            } else {
              return Center(child: Text("No data found"));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
