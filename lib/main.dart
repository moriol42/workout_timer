import 'package:flutter/material.dart';

import 'pages/exercises_page.dart';
import 'pages/workouts_page.dart';

void main() {
  runApp(const MyApp());
}

List<String> navTitles = <String>['Workout', 'Exercises'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainNavBar(),
    );
  }
}

class MainNavBar extends StatefulWidget {
  const MainNavBar({super.key});

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: <Widget>[
          NavigationDestination(icon: Icon(Icons.assignment), label: navTitles[0]),
          NavigationDestination(icon: Icon(Icons.fitness_center), label: navTitles[1]),
        ],
      ),
      body: <Widget>[
        /// Workouts page
        WorkoutsPage(title: 'Workouts Page'),

        /// Exercises page
        ExercisesPage(title: 'Exercises'),
        ][currentPageIndex],
    );
  }
}
