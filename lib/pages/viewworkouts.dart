import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewWorkouts extends StatelessWidget {
  const ViewWorkouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Your Workouts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance
                  .collection("WorkoutSessions")
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fitness_center,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No workouts yet",
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Start your first workout!",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                final data = doc.data() as Map<String, dynamic>;
                final exercises = data['exercises'] as List<dynamic>;
                final startTime = (data['startTime'] as Timestamp).toDate();
                final duration = data['durationInMinutes'] as int;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: ExpansionTile(
                    leading: _WorkoutTypeIcon(data['workoutType']),
                    title: Text(
                      _formatWorkoutType(data['workoutType']),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '${exercises.length} exercises • ${duration} mins',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      DateFormat('MMM dd').format(startTime),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Started: ${DateFormat('h:mm a').format(startTime)}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  'Duration: $duration minutes',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ...exercises.map(
                              (exercise) => _ExerciseTile(exercise: exercise),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _formatWorkoutType(String type) {
    return type
        .split('-')
        .map((s) => s[0].toUpperCase() + s.substring(1))
        .join(' ');
  }
}

class _WorkoutTypeIcon extends StatelessWidget {
  final String workoutType;

  const _WorkoutTypeIcon(this.workoutType);

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (workoutType) {
      case 'push':
        icon = Icons.fitness_center;
        color = Colors.blue;
        break;
      case 'pull':
        icon = Icons.accessible_forward;
        color = Colors.green;
        break;
      case 'legs':
        icon = Icons.directions_run;
        color = Colors.orange;
        break;
      default:
        icon = Icons.sports_gymnastics;
        color = Colors.purple;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color),
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  final Map<String, dynamic> exercise;

  const _ExerciseTile({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise['exercise']
                      .toString()
                      .split('-')
                      .map((s) => s[0].toUpperCase() + s.substring(1))
                      .join(' '),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '${exercise['weight']} kg × ${exercise['reps']} reps',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (exercise['timestamp'] != null)
            Text(
              DateFormat(
                'h:mm a',
              ).format((exercise['timestamp'] as Timestamp).toDate()),
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
        ],
      ),
    );
  }
}
