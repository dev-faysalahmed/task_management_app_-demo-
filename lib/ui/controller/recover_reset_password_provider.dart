import 'package:flutter/cupertino.dart';

import '../../data/model/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class RecoverResetPasswordProvider extends ChangeNotifier{

  bool _recoverResetPasswordInProgress = false;
  String? _errorMessage;

  bool get recoverResetPasswordInProgress => _recoverResetPasswordInProgress;
  String? get errorMessage => _errorMessage;


  Future<bool> resetPassword(String email, String otp, String password) async{
    bool isSuccess = false;
    _recoverResetPasswordInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "email":email,
      "OTP": otp,
      "password":password
    };

    ApiResponse response = await ApiCaller.postRequest(url: Urls.recoverResetPasswordUrl, body: requestBody);

    if(response.isSuccess){


      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _recoverResetPasswordInProgress = false;
    notifyListeners();

    return isSuccess;

  }

}