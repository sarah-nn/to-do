import 'dart:async';

import 'package:firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'db_service/database.dart';
import 'models/task.dart';
import 'theme/taskflow_theme.dart';
import 'views/home_view.dart';
import 'views/task_details_view.dart';
import 'views/task_editor_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'TaskFlow',
    debugShowCheckedModeBanner: false,
    theme: buildTaskFlowTheme(),
    home: const TaskFlowShell(),
  );
}

class TaskFlowShell extends StatefulWidget {
  const TaskFlowShell({super.key});

  @override
  State<TaskFlowShell> createState() => _TaskFlowShellState();
}

class _TaskFlowShellState extends State<TaskFlowShell> {
  Task? selected;
  bool editing = false;
  DataBaseService? _dbService;
  StreamSubscription<List<Task>>? _tasksSubscription;
  List<Task> tasks = [
    Task(
      'Finalize Q3 Design System tokens',
      'Align semantic color variables with engineering team',
      'Today, 2:30 PM',
      'Work',
      Priority.high,
    ),
    Task(
      'Conduct user feedback interview with Sarah M.',
      'Review prototype recordings and synthesize notes',
      'Today, 4:00 PM',
      'Research',
      Priority.medium,
    ),
    Task(
      'Pick up organic groceries & matcha',
      'Whole Foods market on 4th street',
      'Today, 6:30 PM',
      'Personal',
      Priority.low,
    ),
    Task(
      'Morning standup & sprint planning',
      'Completed at 9:15 AM',
      '',
      'Team',
      Priority.low,
      completed: true,
    ),
    Task(
      'Review design pull request #142',
      'Completed at 11:30 AM',
      '',
      'Work',
      Priority.low,
      completed: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeFirestore();
  }

  Future<void> _initializeFirestore() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    if (!mounted) return;

    _dbService = DataBaseService();
    _tasksSubscription = _dbService!.getTasks().listen((taskList) {
      if (!mounted) return;
      setState(() => tasks = taskList);
    });
  }

  @override
  void dispose() {
    _tasksSubscription?.cancel();
    super.dispose();
  }

  void openEditor([Task? task]) => setState(() {
    selected = task;
    editing = true;
  });

  void saveTask(
    String title,
    String description,
    String category,
    Priority priority,
    String date,
    String time,
  ) {
    final task = selected;

    if (task == null) {
      final newTask = Task(
        title,
        description,
        time,
        category,
        priority,
        date: date,
      );
      if (_dbService != null) {
        _dbService!.addTask(newTask);
      } else {
        tasks.insert(0, newTask);
      }
    } else {
      task
        ..title = title
        ..description = description
        ..category = category
        ..priority = priority
        ..date = date
        ..time = time;
      if (_dbService != null) {
        _dbService!.updateTask(task);
      }
    }

    setState(() {
      editing = false;
      selected = null;
    });
  }

  void toggleTask(Task task) {
    task.completed = !task.completed;
    if (_dbService != null) {
      _dbService!.updateTask(task);
    }
  }

  void deleteTask(Task task) {
    if (_dbService != null) {
      _dbService!.deleteTask(task.id);
    } else {
      tasks.removeWhere((item) => item == task);
    }
    setState(() {
      selected = null;
      editing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = editing
        ? TaskEditor(
            task: selected,
            onCancel: () => setState(() => editing = false),
            onSave: saveTask,
          )
        : selected != null
        ? TaskDetails(
            task: selected!,
            onBack: () => setState(() => selected = null),
            onEdit: () => openEditor(selected),
            onDelete: () => deleteTask(selected!),
            onUpdate: (updatedTask) {
              if (_dbService != null) {
                _dbService!.updateTask(updatedTask);
              }
              setState(() => selected = updatedTask);
            },
          )
        : HomeTasks(
            tasks: tasks,
            onTaskTap: (task) => setState(() => selected = task),
            onAdd: openEditor,
            onToggle: toggleTask,
          );

    return Scaffold(
      body: SafeArea(bottom: false, child: content),
      // bottomNavigationBar: (editing || selected != null)
      //     ? null
      //     : NavigationBar(
      //         backgroundColor: Colors.white,
      //         destinations: const [
      //           NavigationDestination(
      //             icon: Icon(Icons.checklist_outlined),
      //             selectedIcon: Icon(Icons.checklist),
      //             label: 'Tasks',
      //           ),
      //           NavigationDestination(
      //             icon: Icon(Icons.add_circle_outline, size: 36),
      //             selectedIcon: Icon(Icons.add_circle, size: 36),
      //             label: '',
      //           ),
      //           NavigationDestination(
      //             icon: Icon(Icons.assignment_outlined),
      //             selectedIcon: Icon(Icons.assignment),
      //             label: 'Details',
      //           ),
      //         ],
      //         selectedIndex: 0,
      //         onDestinationSelected: (index) {
      //           if (index == 1) openEditor();
      //         },
      //       ),
      floatingActionButton: (!editing && selected == null)
          ? FloatingActionButton.extended(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              onPressed: openEditor,
              icon: const Icon(Icons.add),
              label: const Text('Add Task'),
            )
          : null,
    );
  }
}
