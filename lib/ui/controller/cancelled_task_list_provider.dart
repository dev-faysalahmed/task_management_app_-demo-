import 'package:flutter/cupertino.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class CancelledTaskListProvider extends ChangeNotifier{
  bool _getCancelledTaskInProgress = false;
  String? _errorMessage;
  List<TaskModel> _cancelledTaskList = [];

  bool get getCancelledTaskInProgress => _getCancelledTaskInProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get cancelledTaskList => _cancelledTaskList;


  Future<bool> getAllCancelledTaskList() async{
    bool isSuccess = false;
    _getCancelledTaskInProgress = true;
    notifyListeners();

    ApiResponse response = await ApiCaller.getResponse(url: Urls.taskListUrl('Cancelled'));

    if(response.isSuccess){

      List<TaskModel> list = [];

      for(Map<String, dynamic> jsonData in response.responseData['data'] ){
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskList = list;

      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _getCancelledTaskInProgress = false;
    notifyListeners();

    return isSuccess;

  }
}