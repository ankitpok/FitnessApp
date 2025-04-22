import 'package:flutter/material.dart';
import 'package:fitness_app/firestore/add_data.dart' as ad;

class WorkoutEntry extends StatefulWidget {
  const WorkoutEntry({super.key});

  @override
  State<WorkoutEntry> createState() => WorkoutEntryState();
}

class WorkoutEntryState extends State<WorkoutEntry> {
  var weight = '';
  var reps = '';
  var selectedValue = '';
  static const List<DropdownMenuEntry<String>> daysList = [
    DropdownMenuEntry(value: 'push', label: 'Push Day'),
    DropdownMenuEntry(value: 'pull', label: 'Pull Day'),
    DropdownMenuEntry(value: 'legs', label: 'Legs Day'),
  ];
  static const List<DropdownMenuEntry<String>> pushDayList = [
    DropdownMenuEntry(value: 'flat-bench', label: 'Flat Bench'),
    DropdownMenuEntry(value: 'incline-bench', label: 'Incline Bench'),
    DropdownMenuEntry(
      value: 'smith-amchine-incline',
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

  String selectedWorkoutType = ''; // Stores 'push', 'pull' or 'legs'
  String selectedDayVariant = ''; // Stores '1', '2' or '3'
  List<DropdownMenuEntry<String>> currentDayList = [];
  List<String> exerciseInfo = [];
  final TextEditingController _rcontroller = TextEditingController();
  final TextEditingController _wcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entry Section"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownMenu(
                label: const Text("what are we hitting today?"),
                dropdownMenuEntries: daysList,
                initialSelection: daysList.first,
                onSelected: (value) {
                  setState(() {
                    selectedWorkoutType = value.toString();
                    selectedDayVariant = '';

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
              DropdownMenu<String>(
                label: Text('Select $selectedWorkoutType variant'),
                dropdownMenuEntries: currentDayList,
                onSelected: (entry) {
                  setState(() {
                    selectedDayVariant = entry.toString();
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _wcontroller,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  label: Text("Enter weight"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _rcontroller,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  label: Text("Enter Reps you performed"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ad.addData(
                    selectedWorkoutType,
                    selectedDayVariant,
                    weight,
                    reps,
                  );

                  setState(() {
                    reps = _rcontroller.text.toString();
                    weight = _wcontroller.text.toString();
                    //selectedDayVariant = selectedDayVariant;
                  });
                },
                child: const Text("Print"),
              ),
              Text(reps.toString()),
              Text(weight.toString()),
              Text(selectedDayVariant.toString()),
              Text(selectedWorkoutType.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
