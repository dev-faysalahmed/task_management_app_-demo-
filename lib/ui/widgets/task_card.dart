import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/data/model/task_model.dart';
import 'package:task_management_project/data/services/api_caller.dart';
import 'package:task_management_project/ui/controller/new_task_list_provider.dart';
import 'package:task_management_project/ui/controller/task_status_count_provider.dart';
import 'package:task_management_project/ui/widgets/snack_bar_message.dart';

import '../../data/utils/urls.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key, required this.taskModel, required this.chipColor, required this.refreshParent,
  });

  final TaskModel taskModel;
  final Color chipColor;
  final VoidCallback refreshParent;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  bool _changeStatusInProgress = false;
  bool _deleteInProgress = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.white,
      title: Text(widget.taskModel.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(widget.taskModel.description),
          Text('Date: ${widget.taskModel.createdDate}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
          Row(children: [
            Chip(label: Text(widget.taskModel.status, style: TextStyle(color: Colors.white),), backgroundColor: widget.chipColor ?? Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), padding: EdgeInsets.symmetric(horizontal: 16),),
            Spacer(),
            Visibility(
              visible: _deleteInProgress == false,
              replacement: Center(child: CircularProgressIndicator(),),
              child: IconButton(onPressed: (){
                _deleteTask();
              }, icon: Icon(Icons.delete, color: Colors.red,)),
            ),
            Visibility(
              visible: _changeStatusInProgress == false,
                replacement: Center(child: CircularProgressIndicator(),),
                child: IconButton(onPressed: (){
                  _showChangeStatusDialogue();
                  }, icon: Icon(Icons.edit, color: Colors.grey,))),
          ],),
        ],
      ),
    );
  }

  void _showChangeStatusDialogue(){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: Text('Change Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: (){_changeStatus('New');},
              title: Text("New"),
              trailing: widget.taskModel.status == 'New' ? Icon(Icons.done,):null,
            ),
            ListTile(
              onTap: (){_changeStatus('Progress');},
              title: Text("Progress"),
              trailing: widget.taskModel.status == 'Progress' ? Icon(Icons.done,):null,
            ),

            ListTile(
              onTap: (){_changeStatus('Cancelled');},
              title: Text("Cancelled"),
              trailing: widget.taskModel.status == 'Cancelled' ? Icon(Icons.done,):null,
            ),

            ListTile(
              onTap: (){_changeStatus('Completed');},
              title: Text("Completed"),
              trailing: widget.taskModel.status == 'Completed' ? Icon(Icons.done,):null,
            ),
          ],
        ),
      );
    });
  }

  Future<void> _changeStatus(String status)async{
    if(status == widget.taskModel.status){
      return;
    }
    Navigator.pop(context);

    _changeStatusInProgress = true;
    setState(() {});
    
    final ApiResponse response = await ApiCaller.getResponse(url: Urls.updateStatusUrl(widget.taskModel.id, status));

    _changeStatusInProgress = false;
    setState(() {});

    if(response.isSuccess){
      widget.refreshParent();
    }else{
      snackBarMessage(context, response.errorMessage!);
    }
  }

  Future<void> _deleteTask()async{
    _deleteInProgress = true;
    setState(() {});

    final ApiResponse apiResponse = await ApiCaller.getResponse(url: Urls.deleteTask(widget.taskModel.id));

    _deleteInProgress = false;
    setState(() {});

    if(apiResponse.isSuccess){
      widget.refreshParent();
      snackBarMessage(context, apiResponse.responseData);
    }else{
      snackBarMessage(context, apiResponse.errorMessage.toString());
    }
  }


}