import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

void addData(
  String dayType,
  String exercise,
  String weight,
  String reps,
) async {
  //final dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final timestamp = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());

  final docId = '${dayType.toLowerCase()}_$timestamp';

  try {
    await FirebaseFirestore.instance
        .collection('Exercise Entry')
        .doc(docId)
        .set({
          'dayType': dayType,
          'exercise': exercise,
          'weight': weight,
          'reps': reps,
          'timestamp': FieldValue.serverTimestamp(),
        });
  } catch (e) {
    print('Error adding document: $e');
  }
}
