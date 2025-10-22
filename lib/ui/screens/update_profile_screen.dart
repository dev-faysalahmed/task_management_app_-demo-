import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/data/model/user_model.dart';
import 'package:task_management_project/data/services/api_caller.dart';
import 'package:task_management_project/ui/controller/auth_controller.dart';
import 'package:task_management_project/ui/controller/update_profile_provider.dart';
import 'package:task_management_project/ui/screens/photo_picker_field.dart';
import 'package:task_management_project/ui/widgets/screen_background.dart';
import 'package:task_management_project/ui/widgets/snack_bar_message.dart';
import 'package:task_management_project/ui/widgets/tm_app_bar.dart';

import '../../data/utils/urls.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = '/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UpdateProfileProvider _updateProfileProvider = UpdateProfileProvider();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();

    UserModel user = AuthController.userModel!;
    _emailTEController.text = user.email;
    _firstNameTEController.text = user.firstName;
    _lastNameTEController.text = user.lastName;
    _mobileTEController.text = user.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromUpdateProfile: true,),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24,),
                  Text('Update Profile', style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 8,),
                  PhotoPickerField(
                    onTap: _pickImage,
                    selectedPhoto: _selectedImage,
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(hintText: 'Email'),
                    enabled: false,
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "please input valid first name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "please input valid last name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _mobileTEController,
                    decoration: InputDecoration(hintText: 'Mobile'),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "please input valid mobile number";
                      }else if(value?.trim().length != 11){
                        return "please enter 11 digit mobile number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true, decoration: InputDecoration(hintText: 'Password (Optional)'),
                    validator: (String? value){
                      if((value != null && value.isNotEmpty) && value.length<6){
                        return "enter a valid 6 digit password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  Consumer<UpdateProfileProvider>(
                    builder: (context, provider, _) {
                      return Visibility(
                        visible: provider.updateProfileInProgress == false,
                        replacement: Center(child: CircularProgressIndicator(),),
                        child: FilledButton(
                            onPressed: _onTapUpdateButton,
                            child: Icon(Icons.arrow_circle_right_outlined)
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapUpdateButton(){
    if(_formKey.currentState!.validate()){
      _updateProfile();
    }
  }
  Future<void> _pickImage()async{
    XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      _selectedImage = pickedImage;
      setState(() {});
    }
  }

  Future<void> _updateProfile()async {

    final bool isSuccess = await _updateProfileProvider.updateUser(email: _emailTEController.text.trim(), firstName: _firstNameTEController.text.trim(), lastName: _lastNameTEController.text.trim(), mobile: _mobileTEController.text.trim(), password: _passwordTEController.text.trim(), selectedImage: _selectedImage, context: context);
    if(isSuccess){
      _passwordTEController.clear();
      snackBarMessage(context, "Profile has been updated.");
    }else{
      snackBarMessage(context, _updateProfileProvider.errorMessage!);
    }

    /*
    _updateProfileInProgress = true;
    setState(() {});

    final Map<String, dynamic> requestBody = {
      "email":_emailTEController.text,
      "firstName":_firstNameTEController.text.trim(),
      "lastName":_lastNameTEController.text.trim(),
      "mobile":_mobileTEController.text.trim(),
    };

    if(_passwordTEController.text.isNotEmpty){
      requestBody["password"] = _passwordTEController.text;
    }
    String? encodedPhoto;
    if(_selectedImage != null){
      Uint8List bytes = await _selectedImage!.readAsBytes();
      encodedPhoto = base64Encode(bytes);
      requestBody["photo"] = jsonEncode(bytes);
    }

    final ApiResponse apiResponse = await ApiCaller.postRequest(url: Urls.updateProfileUrl, body: requestBody);

    _updateProfileInProgress = false;
    setState(() {});

    if(apiResponse.isSuccess){
      _passwordTEController.clear();
      snackBarMessage(context, "Profile has been updated.");
      UserModel model = UserModel(id: AuthController.userModel!.id, email: _emailTEController.text, firstName: _firstNameTEController.text.trim(), lastName: _lastNameTEController.text.trim(), mobile: _mobileTEController.text.trim(), photo: encodedPhoto ?? AuthController.userModel!.photo);
      await AuthController.updateUserData(model);
    }else{
      snackBarMessage(context, apiResponse.errorMessage!);
    }

     */
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    super.dispose();
  }
}


