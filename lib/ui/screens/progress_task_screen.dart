import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/ui/controller/progress_task_list_provider.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  final ProgressTaskListProvider _progressTaskListProvider = ProgressTaskListProvider();

  @override
  void initState() {
    super.initState();
    _progressTaskListProvider.getAllProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _progressTaskListProvider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(child: Consumer<ProgressTaskListProvider>(
                builder: (context, progressTaskListProvider, _) {
                  return Visibility(
                    visible: progressTaskListProvider.getProgressTaskInProgress == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return TaskCard(taskModel: progressTaskListProvider.progressTaskList[index], chipColor: Colors.purple, refreshParent: (){
                            progressTaskListProvider.getAllProgressTaskList();
                          });
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8,);
                        },
                        itemCount: progressTaskListProvider.progressTaskList.length),
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




