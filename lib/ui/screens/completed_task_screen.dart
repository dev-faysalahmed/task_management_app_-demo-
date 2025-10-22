import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/ui/controller/completed_task_list_provider.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  final CompletedTaskListProvider _completedTaskListProvider = CompletedTaskListProvider();

  @override
  void initState() {
    super.initState();
    _completedTaskListProvider.getAllCompletedTaskList();
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _completedTaskListProvider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(child: Consumer<CompletedTaskListProvider>(
                builder: (context, completedTaskListProvider, _) {
                  return Visibility(
                    visible: completedTaskListProvider.getCompletedTaskInProgress == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return TaskCard(taskModel: completedTaskListProvider.completedTaskList[index], chipColor: Colors.green, refreshParent: (){
                            completedTaskListProvider.getAllCompletedTaskList();
                          });
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8,);
                        },
                        itemCount: completedTaskListProvider.completedTaskList.length),
                  );
                }
              ))
            ],
          ),
        ),
      ),
    );
  }
}




