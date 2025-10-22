import 'package:flutter/cupertino.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class CompletedTaskListProvider extends ChangeNotifier{
  bool _getCompletedTaskInProgress = false;
  String? _errorMessage;
  List<TaskModel> _completedTaskList = [];

  bool get getCompletedTaskInProgress => _getCompletedTaskInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get completedTaskList => _completedTaskList;


  Future<bool> getAllCompletedTaskList() async{
    bool isSuccess = false;
    _getCompletedTaskInProgress = true;
    notifyListeners();

    ApiResponse response = await ApiCaller.getResponse(url: Urls.taskListUrl('Completed'));

    if(response.isSuccess){

      List<TaskModel> list = [];

      for(Map<String, dynamic> jsonData in response.responseData['data'] ){
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedTaskList = list;

      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _getCompletedTaskInProgress = false;
    notifyListeners();

    return isSuccess;

  }
}