import 'package:flutter/cupertino.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class ProgressTaskListProvider extends ChangeNotifier{
  bool _getProgressTaskInProgress = false;
  String? _errorMessage;
  List<TaskModel> _progressTaskList = [];

  bool get getProgressTaskInProgress => _getProgressTaskInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get progressTaskList => _progressTaskList;


  Future<bool> getAllProgressTaskList() async{
    bool isSuccess = false;
    _getProgressTaskInProgress = true;
    notifyListeners();

    ApiResponse response = await ApiCaller.getResponse(url: Urls.taskListUrl('Progress'));

    if(response.isSuccess){

      List<TaskModel> list = [];

      for(Map<String, dynamic> jsonData in response.responseData['data'] ){
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;

      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _getProgressTaskInProgress = false;
    notifyListeners();

    return isSuccess;

  }
}