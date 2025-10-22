import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../data/model/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import 'auth_controller.dart';

class UpdateProfileProvider extends ChangeNotifier{

  bool _updateProfileInProgress = false;
  String? _errorMessage;

  bool get updateProfileInProgress => _updateProfileInProgress;
  String? get errorMessage => _errorMessage;


  Future<bool> updateUser(
      {required String email, required String firstName, required String lastName, required String mobile, String? password, XFile? selectedImage, required BuildContext context}) async{
    bool isSuccess = false;
    _updateProfileInProgress = true;
    notifyListeners();

    final Map<String, dynamic> requestBody = {
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,
    };

    if(password!.isNotEmpty){
      requestBody["password"] = password;
    }
    String? encodedPhoto;
    if(selectedImage != null){
      Uint8List bytes = await selectedImage.readAsBytes();
      encodedPhoto = base64Encode(bytes);
      requestBody["photo"] = base64Encode(bytes);
    }

    ApiResponse response = await ApiCaller.postRequest(url: Urls.updateProfileUrl, body: requestBody);

    if(response.isSuccess){
      UserModel model = UserModel(id: AuthController.userModel!.id, email: email, firstName: firstName, lastName: lastName, mobile: mobile, photo: encodedPhoto ?? AuthController.userModel!.photo);
      await context.read<AuthController>().updateUserData(model);
      notifyListeners();
      _errorMessage = null;
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }

    _updateProfileInProgress = false;
    notifyListeners();

    return isSuccess;

  }

}