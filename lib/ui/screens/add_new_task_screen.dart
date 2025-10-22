import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/data/services/api_caller.dart';
import 'package:task_management_project/data/utils/urls.dart';
import 'package:task_management_project/ui/controller/new_task_list_provider.dart';
import 'package:task_management_project/ui/controller/task_status_count_provider.dart';
import 'package:task_management_project/ui/widgets/screen_background.dart';
import 'package:task_management_project/ui/widgets/snack_bar_message.dart';
import 'package:task_management_project/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();

  bool _addNewTaskProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUnfocus,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32,),
                  Text('Add New Task', style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _titleTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Title'
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Set a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 8,
                    decoration: InputDecoration(
                        hintText: 'Description'
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Set a description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  Visibility(
                    visible: _addNewTaskProgress == false,
                      replacement: Center(child: CircularProgressIndicator(),),
                      child: FilledButton(onPressed: _ioTapAddButton, child: Text('Add')))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _ioTapAddButton(){
    if(_formKey.currentState!.validate()){

      _addNewTask();

    }
  }

  Future<void> _addNewTask()async{
    _addNewTaskProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title":_titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status":"New"
    };
    final ApiResponse response = await ApiCaller.postRequest(url: Urls.createNewTaskUrl, body: requestBody);

    _addNewTaskProgress = false;
    setState(() {});

    if(response.isSuccess){
      _clearText();
      snackBarMessage(context, 'Your Task Successfully Added.');
      context.read<NewTaskListProvider>().getAllNewTaskList();
      context.read<TaskStatusCountProvider>().getAllTaskStatusCountList();
    }else{
      snackBarMessage(context, response.errorMessage!);
    }
  }

  void _clearText(){
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
