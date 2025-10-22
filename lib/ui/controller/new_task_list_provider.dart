import 'package:flutter/cupertino.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';


class NewTaskListProvider extends ChangeNotifier{
  bool _newTaskInProgress = false;
  String? _errorMessage;
  List<TaskModel> _newTaskList = [];

  bool get newTaskInProgress => _newTaskInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get newTaskList => _newTaskList;


  Future<bool> getAllNewTaskList() async{
    bool isSuccess = false;
    _newTaskInProgress = true;
    notifyListeners();

    ApiResponse response = await ApiCaller.getResponse(url: Urls.taskListUrl('New'));

    if(response.isSuccess && response.responseData['status'] == 'success'){

      List<TaskModel> list = [];

      for(Map<String, dynamic> jsonData in response.responseData['data'] ){
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;

      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _newTaskInProgress = false;
    notifyListeners();

    return isSuccess;

  }
}