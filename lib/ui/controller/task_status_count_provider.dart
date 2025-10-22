import 'package:flutter/cupertino.dart';

import '../../data/model/task_model.dart';
import '../../data/model/task_status_count_model.dart';
import '../../data/model/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class TaskStatusCountProvider extends ChangeNotifier{
  bool _getStatusCountInProgress = false;
  String? _errorMessage;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  bool get getStatusCountInProgress => _getStatusCountInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskStatusCountModel> get taskStatusCountList => _taskStatusCountList;


  Future<bool> getAllTaskStatusCountList() async{
    bool isSuccess = false;
    _getStatusCountInProgress = true;
    notifyListeners();

    ApiResponse response = await ApiCaller.getResponse(url: Urls.taskStatusCountUrl);

    if(response.isSuccess){

      List<TaskStatusCountModel> list = [];

      for(Map<String, dynamic> jsonData in response.responseData['data'] ){
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;

      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _getStatusCountInProgress = false;
    notifyListeners();

    return isSuccess;

  }

  void removeTask(String status){
    _taskStatusCountList.removeWhere((e) => e.status == status);
    getAllTaskStatusCountList();
    notifyListeners();
  }
}