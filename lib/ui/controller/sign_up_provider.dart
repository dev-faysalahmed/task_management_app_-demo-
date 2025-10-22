import 'package:flutter/cupertino.dart';

import '../../data/model/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class SignUpProvider extends ChangeNotifier{

  bool _signUpInProgress = false;
  String? _errorMessage;

  bool get signUpInProgress => _signUpInProgress;
  String? get errorMessage => _errorMessage;


  Future<bool> signUpUser(
      {required String email,required String firstName,required String lastName,required String mobile,required String password}) async{
    bool isSuccess = false;
    _signUpInProgress = true;
    notifyListeners();

    Map<String, dynamic> requestBody = {
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,
      "password":password
    };

    ApiResponse response = await ApiCaller.postRequest(url: Urls.signUpUrl, body: requestBody);

    if(response.isSuccess){

      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _signUpInProgress = false;
    notifyListeners();

    return isSuccess;

  }

}