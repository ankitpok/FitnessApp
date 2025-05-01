import 'package:flutter/material.dart';
import 'package:fitness_app/firestore/add_data.dart' as ad;

class WorkoutEntry extends StatefulWidget {
  const WorkoutEntry({super.key});

  @override
  State<WorkoutEntry> createState() => WorkoutEntryState();
}

class WorkoutEntryState extends State<WorkoutEntry> {
  static const List<DropdownMenuEntry<String>> daysList = [
    DropdownMenuEntry(value: 'push', label: 'Push Day'),
    DropdownMenuEntry(value: 'pull', label: 'Pull Day'),
    DropdownMenuEntry(value: 'legs', label: 'Legs Day'),
  ];

  static const List<DropdownMenuEntry<String>> pushDayList = [
    DropdownMenuEntry(value: 'flat-bench', label: 'Flat Bench'),
    DropdownMenuEntry(value: 'incline-bench', label: 'Incline Bench'),
    DropdownMenuEntry(
      value: 'smith-machine-incline',
      label: 'Smith Machine Incline',
    ),
  ];

  static const List<DropdownMenuEntry<String>> pullDayList = [
    DropdownMenuEntry(value: 'lat-pulldown', label: 'Lat Pulldown'),
    DropdownMenuEntry(value: 'seated-cable-row', label: 'Seated Cable Row'),
    DropdownMenuEntry(value: 'deadlift', label: 'Deadlift'),
  ];

  static const List<DropdownMenuEntry<String>> legsDayList = [
    DropdownMenuEntry(value: 'barbell-squat', label: 'Barbell Squat'),
    DropdownMenuEntry(value: 'leg-press', label: 'Leg Press'),
    DropdownMenuEntry(value: 'hack-squat', label: 'Hack Squat'),
  ];

  String selectedWorkoutType = '';
  String selectedExercise = '';
  List<DropdownMenuEntry<String>> currentDayList = [];

  final TextEditingController _rcontroller = TextEditingController();
  final TextEditingController _wcontroller = TextEditingController();

  // List to hold all exercises for the current workout session
  List<Map<String, dynamic>> exercises = [];

  // To track if we're in the middle of a workout session
  bool workoutInProgress = false;
  DateTime? workoutStartTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Workout Entry",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!workoutInProgress) ...[
                DropdownMenu(
                  label: const Text("What are we hitting today?"),
                  dropdownMenuEntries: daysList,
                  onSelected: (value) {
                    setState(() {
                      selectedWorkoutType = value.toString();
                      selectedExercise = '';

                      switch (value) {
                        case 'push':
                          currentDayList = pushDayList;
                          break;
                        case 'pull':
                          currentDayList = pullDayList;
                          break;
                        case 'legs':
                          currentDayList = legsDayList;
                          break;
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (selectedWorkoutType.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        workoutInProgress = true;
                        workoutStartTime = DateTime.now();
                        exercises.clear();
                      });
                    },
                    child: const Text("Start Workout Session"),
                  ),
              ] else ...[
                Text(
                  "Current Workout: ${selectedWorkoutType.toUpperCase()}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                DropdownMenu<String>(
                  label: Text('Select exercise'),
                  dropdownMenuEntries: currentDayList,
                  onSelected: (entry) {
                    setState(() {
                      selectedExercise = entry.toString();
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _wcontroller,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    label: Text("Enter weight (kg/lbs)"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _rcontroller,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    label: Text("Enter reps performed"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (selectedExercise.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select an exercise")),
                      );
                      return;
                    }

                    setState(() {
                      exercises.add({
                        'exercise': selectedExercise,
                        'weight': _wcontroller.text,
                        'reps': _rcontroller.text,
                        'timestamp': DateTime.now(),
                      });

                      // Clear fields for next entry
                      _wcontroller.clear();
                      _rcontroller.clear();
                      selectedExercise = '';
                    });
                  },
                  child: const Text("Add Exercise"),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            exercise['exercise']
                                .toString()
                                .split('-')
                                .map((s) => s[0].toUpperCase() + s.substring(1))
                                .join(' '),
                          ),
                          subtitle: Text(
                            "${exercise['weight']} kg × ${exercise['reps']} reps",
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                exercises.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Submit all exercises to Firestore
                    ad.addWorkoutData(
                      selectedWorkoutType,
                      exercises,
                      workoutStartTime!,
                      DateTime.now(),
                    );

                    setState(() {
                      workoutInProgress = false;
                      selectedWorkoutType = '';
                      exercises.clear();
                    });
                  },
                  child: const Text("Finish Workout"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
