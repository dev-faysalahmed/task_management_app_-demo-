import 'package:flutter/material.dart';
import 'package:task_management_project/ui/screens/add_new_task_screen.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 16,),
            SizedBox(
              height: 80,
              child: ListView.separated(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TaskCountByStatusCard(title: 'New', count: 09,);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 4,);
                },
              ),
            ),
            Expanded(child: ListView.separated(
                itemBuilder: (context, index) {
                  return TaskCard(chipTitle: 'New', chipColor: Colors.blue,);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8,);
                },
                itemCount: 10))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _onTapAddNewTaskButton, child: Icon(Icons.add),)
    );
  }

  void _onTapAddNewTaskButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewTaskScreen(),));
  }

}




