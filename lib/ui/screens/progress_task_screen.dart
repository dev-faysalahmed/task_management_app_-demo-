import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(child: ListView.separated(
                itemBuilder: (context, index) {
                  return TaskCard(chipTitle: 'Progress', chipColor: Colors.purple,);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8,);
                },
                itemCount: 10))
          ],
        ),
      ),
    );
  }
}




