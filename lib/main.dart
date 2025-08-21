import 'package:flutter/material.dart';

import 'pages/exercises_page.dart';
import 'pages/workouts_page.dart';
import 'back/back.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: MainNavBar(),
    );
  }
}

class NavDest {
  const NavDest(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

class MainNavBar extends StatefulWidget {
  const MainNavBar({super.key});

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int currentPageIndex = 0;
  final destinations = [
    NavDest('Workout', Icon(Icons.assignment_outlined), Icon(Icons.assignment)),
    NavDest(
      'Exercise',
      Icon(Icons.fitness_center_outlined),
      Icon(Icons.fitness_center),
    ),
  ];

  Widget body() {
    return <Widget>[
      /// Workouts page
      WorkoutsPage(title: 'Workouts'),

      /// Exercises page
      ExercisesPage(title: 'Exercises'),
    ][currentPageIndex];
  }

  Widget buildScafoldNavRail() {
    bool extended = MediaQuery.of(context).size.width >= 700;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: destinations
                .map(
                  (d) => NavigationRailDestination(
                    icon: d.icon,
                    selectedIcon: d.selectedIcon,
                    label: Text(d.label),
                    padding: const EdgeInsets.symmetric(horizontal:  5.0, vertical: 8.0),
                  ),
                )
                .toList(),
            selectedIndex: currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            extended: extended,
            labelType: extended
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
          ),
          const VerticalDivider(),
          Expanded(child: body()),
        ],
      ),
    );
  }

  Widget buildScafoldBottomNavBar() {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: destinations
            .map(
              (d) => NavigationDestination(
                icon: d.icon,
                label: d.label,
                selectedIcon: d.selectedIcon,
                tooltip: d.label,
              ),
            )
            .toList(),
      ),
      body: body(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width >= 450
        ? buildScafoldNavRail()
        : buildScafoldBottomNavBar();
  }
}
