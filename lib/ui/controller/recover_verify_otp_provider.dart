import 'package:flutter/cupertino.dart';
import 'package:task_management_project/ui/widgets/snack_bar_message.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class RecoverVerifyOtpProvider extends ChangeNotifier{
  bool _recoverVerifyOtpInProgress = false;
  String? _errorMessage;

  bool get recoverVerifyOtpInProgress => _recoverVerifyOtpInProgress;
  String? get errorMessage => _errorMessage;


  Future<bool> otpVerify(String email, String otp) async{
    bool isSuccess = false;
    _recoverVerifyOtpInProgress = true;
    notifyListeners();

    ApiResponse response = await ApiCaller.getResponse(url: Urls.recoverVerifyOtpUrl(email, otp));

    if(response.isSuccess && response.responseData['status'] == 'success'){

      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _recoverVerifyOtpInProgress = false;
    notifyListeners();

    return isSuccess;

  }
}