import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/ui/controller/new_task_list_provider.dart';
import 'package:task_management_project/ui/controller/task_status_count_provider.dart';
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
  void initState() {
    super.initState();
    context.read<TaskStatusCountProvider>().getAllTaskStatusCountList();
    context.read<NewTaskListProvider>().getAllNewTaskList();
  }


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
              child: Consumer<TaskStatusCountProvider>(
                builder: (context, taskStatusCountProvider, _) {
                  return Visibility(
                    visible: taskStatusCountProvider.getStatusCountInProgress == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: ListView.separated(
                      itemCount: taskStatusCountProvider.taskStatusCountList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return TaskCountByStatusCard(title: taskStatusCountProvider.taskStatusCountList[index].status, count: taskStatusCountProvider.taskStatusCountList[index].count,);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 4,);
                      },
                    ),
                  );
                }
              ),
            ),
            Expanded(
                child: Consumer<NewTaskListProvider>(
                  builder: (context, newTaskListProvider, _) {
                    return Visibility(
                                  visible: newTaskListProvider.newTaskInProgress == false,
                                  replacement: Center(child: CircularProgressIndicator(),),
                                  child: ListView.separated(
                      itemBuilder: (context, index) {

                        return TaskCard(taskModel: newTaskListProvider.newTaskList[index], chipColor: Colors.blue, refreshParent: () {
                          newTaskListProvider.getAllNewTaskList();
                          context.read<TaskStatusCountProvider>().getAllTaskStatusCountList();
                          context.read<TaskStatusCountProvider>().removeTask(newTaskListProvider.newTaskList[index].status);
                        },);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 8,);
                      },
                      itemCount: newTaskListProvider.newTaskList.length),
                                );
                  }
                ))
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




