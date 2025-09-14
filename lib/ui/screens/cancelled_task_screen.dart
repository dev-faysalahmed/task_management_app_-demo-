import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(child: ListView.separated(
                itemBuilder: (context, index) {
                  return TaskCard(chipTitle: 'Cancelled', chipColor: Colors.red);
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




