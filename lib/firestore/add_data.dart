import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<void> addWorkoutData(
  String workoutType,
  List<Map<String, dynamic>> exercises,
  DateTime startTime,
  DateTime endTime,
) async {
  try {
    final docId = '${workoutType}_${startTime.millisecondsSinceEpoch}';

    await FirebaseFirestore.instance
        .collection('WorkoutSessions')
        .doc(docId)
        .set({
          'workoutType': workoutType,
          'exercises': exercises,
          'startTime': startTime,
          'endTime': endTime,
          'durationInMinutes': endTime.difference(startTime).inMinutes,
          'timestamp': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

    if (kDebugMode) {
      print('Workout saved successfully with ID: $docId');
    }
  } catch (e, stack) {
    if (kDebugMode) {
      print('Error saving workout: $e');
      print('Stack trace: $stack');
    }
    rethrow;
  }
}
