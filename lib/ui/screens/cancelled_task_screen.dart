import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/ui/controller/cancelled_task_list_provider.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  final CancelledTaskListProvider _cancelledTaskListProvider = CancelledTaskListProvider();

  @override
  void initState() {
    super.initState();
    _cancelledTaskListProvider.getAllCancelledTaskList();
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _cancelledTaskListProvider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                  child: Consumer<CancelledTaskListProvider>(
                    builder: (context, cancelledTaskListProvider, _) {
                      return Visibility(
                        visible: cancelledTaskListProvider.getCancelledTaskInProgress == false,
                        replacement: Center(child: CircularProgressIndicator(),),
                        child: ListView.separated(
                        itemBuilder: (context, index) {
                          return TaskCard(taskModel: cancelledTaskListProvider.cancelledTaskList[index], chipColor: Colors.red, refreshParent: (){
                            cancelledTaskListProvider.getAllCancelledTaskList();
                          });
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8,);
                        },
                        itemCount: cancelledTaskListProvider.cancelledTaskList.length),
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




