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
    DropdownMenuEntry(value: 'Cable Press', label: 'Cable Press'),
    DropdownMenuEntry(
      value: 'smith-machine-incline',
      label: 'Smith Machine Incline',
    ),
    DropdownMenuEntry(value: 'cable-tricep', label: 'Cable Tricep Pushdown'),
    DropdownMenuEntry(value: 'cable-OH', label: 'Cable Tricep OH extentsion'),
  ];

  static const List<DropdownMenuEntry<String>> pullDayList = [
    DropdownMenuEntry(value: 'lat-pulldown', label: 'Lat Pulldown'),
    DropdownMenuEntry(
      value: 'chest-supported-row',
      label: 'Chest Supported Row',
    ),
    DropdownMenuEntry(value: 'deadlift', label: 'Deadlift'),
    DropdownMenuEntry(value: 'cable-curl', label: 'Cable Curl'),
    DropdownMenuEntry(value: 'db-curl', label: 'Dumbell Curl'),
  ];

  static const List<DropdownMenuEntry<String>> legsDayList = [
    DropdownMenuEntry(value: 'barbell-squat', label: 'Barbell Squat'),
    DropdownMenuEntry(value: 'leg-press', label: 'Leg Press'),
    DropdownMenuEntry(value: 'hack-squat', label: 'Hack Squat'),
    DropdownMenuEntry(value: 'leg-extension', label: 'Leg Extension'),
    DropdownMenuEntry(value: 'hamstring', label: 'Lying Hamstring'),
    DropdownMenuEntry(value: 'calf-raises', label: 'Calf Raises'),
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
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Workout Entry",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isKeyboard)
                  Image(
                    image: AssetImage('lib/assets/exercise_entry.webp'),
                    height: 150,
                  ),
                if (!workoutInProgress) ...[
                  DropdownMenu(
                    label: const Text(
                      "What are we hitting today?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 13,
                      ),
                    ),
                    dropdownMenuEntries: daysList,
                    menuStyle: MenuStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 255, 255, 255),
                      ), // Dropdown background
                      elevation: WidgetStateProperty.all(5), // Shadow
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // Rounded corners
                          side: BorderSide(
                            color: const Color.fromARGB(255, 242, 242, 242),
                          ), // Border
                        ),
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.all(8),
                      ), // Inner padding
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: const Color.fromARGB(
                        255,
                        240,
                        237,
                        237,
                      ), // Background color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 254, 254, 254),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
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
                      child: const Text(
                        "Start Workout Session",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                ] else ...[
                  Text(
                    "Current Workout: ${selectedWorkoutType.toUpperCase()}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownMenu<String>(
                    label: Text(
                      'Select exercise',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    dropdownMenuEntries: currentDayList,
                    menuStyle: MenuStyle(
                      backgroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 255, 255, 255),
                      ), // Dropdown background
                      elevation: WidgetStateProperty.all(5), // Shadow
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // Rounded corners
                          side: BorderSide(
                            color: const Color.fromARGB(255, 242, 242, 242),
                          ), // Border
                        ),
                      ),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.all(8),
                      ), // Inner padding
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: const Color.fromARGB(
                        255,
                        240,
                        237,
                        237,
                      ), // Background color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 254, 254, 254),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSelected: (entry) {
                      setState(() {
                        selectedExercise = entry.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    controller: _wcontroller,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(
                      label: Text(
                        "Enter weight (kg/lbs)",
                        style: TextStyle(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 143, 139, 139),
                        ), // normal
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 172, 169, 169),
                          width: 2,
                        ), // focused
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // fallback
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    controller: _rcontroller,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(
                      label: Text(
                        "Enter reps performed",
                        style: TextStyle(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 148, 146, 146),
                        ), // normal
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 172, 169, 169),
                          width: 2,
                        ), // focused
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // fallback
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedExercise.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please select an exercise"),
                            ),
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
                                  .map(
                                    (s) => s[0].toUpperCase() + s.substring(1),
                                  )
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
      ),
    );
  }
}
