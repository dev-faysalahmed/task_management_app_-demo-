import 'package:flutter/material.dart';
import 'package:task_management_project/ui/screens/cancelled_task_screen.dart';
import 'package:task_management_project/ui/screens/completed_task_screen.dart';
import 'package:task_management_project/ui/screens/new_task_screen.dart';
import 'package:task_management_project/ui/screens/progress_task_screen.dart';

import '../widgets/tm_app_bar.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  const MainNavBarHolderScreen({super.key});

  static const String name = '/new-task';

  @override
  State<MainNavBarHolderScreen> createState() => _MainNavBarHolderScreenState();
}

class _MainNavBarHolderScreenState extends State<MainNavBarHolderScreen> {

  int _selectedIndex = 0;
  final List<Widget> _screen = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
          onDestinationSelected: (int index){
          _selectedIndex = index;
          setState(() {});
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.new_label_outlined), label: 'New'),
            NavigationDestination(icon: Icon(Icons.run_circle_outlined), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
            NavigationDestination(icon: Icon(Icons.check_circle_outline), label: 'Completed'),
            ]),
      body: _screen[_selectedIndex],
    );
  }
}

