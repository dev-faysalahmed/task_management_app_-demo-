import 'package:flutter/cupertino.dart';
import 'package:task_management_project/ui/widgets/snack_bar_message.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class RecoverVerifyEmailProvider extends ChangeNotifier{
  bool _recoverVerifyEmailInProgress = false;
  String? _errorMessage;

  bool get recoverVerifyEmailInProgress => _recoverVerifyEmailInProgress;
  String? get errorMessage => _errorMessage;


  Future<bool> emailVerify(String email) async{
    bool isSuccess = false;
    _recoverVerifyEmailInProgress = true;
    notifyListeners();

    ApiResponse response = await ApiCaller.getResponse(url: Urls.recoverVerifyEmailUrl(email));

    if(response.isSuccess){

      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _recoverVerifyEmailInProgress = false;
    notifyListeners();

    return isSuccess;

  }
}