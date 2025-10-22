import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/data/services/api_caller.dart';
import 'package:task_management_project/data/utils/urls.dart';
import 'package:task_management_project/ui/controller/sign_up_provider.dart';
import 'package:task_management_project/ui/screens/login_screen.dart';
import 'package:task_management_project/ui/widgets/screen_background.dart';
import 'package:task_management_project/ui/widgets/snack_bar_message.dart';

import '../widgets/circular_progress.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignUpProvider _signUpProvider = SignUpProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _signUpProvider,
      child: Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUnfocus,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 82,),
                    Text('Join With Us', style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 24,),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (String? value) {
                        String textInput = value ?? '';
                        if(EmailValidator.validate(textInput) == false){
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _firstNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'First Name'),
                      validator: (String? value) {
                        if(value?.trim().isEmpty ?? true){
                          return "Enter a valid FirstName";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _lastNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'Last Name'),
                      validator: (String? value) {
                        if(value?.trim().isEmpty ?? true){
                          return "Enter a valid last name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _mobileTEController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(hintText: 'Mobile'),
                      validator: (String? value) {
                        if(value?.length != 11){
                          return "Enter your 11 digit phone number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _passwordTEController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (String? value) {
                        if(value?.length != 6){
                          return "Enter your 6 digit password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),
                    Consumer<SignUpProvider>(
                      builder: (context, provider, _) {
                        return Visibility(
                          visible: provider.signUpInProgress == false,
                          replacement: circularProgress(),
                          child: FilledButton(
                              onPressed: _onTabRegistrationButton,
                              child: Icon(Icons.arrow_circle_right_outlined)
                          ),
                        );
                      }
                    ),
                    SizedBox(height: 36,),
                    Center(
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                            text: "Already have an account? ",
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(color: Colors.green,),
                                recognizer: TapGestureRecognizer()..onTap = _onTapLoginButton,


                              )
                            ]
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTabRegistrationButton(){
    if(_formKey.currentState!.validate()){

      _signUpUser();

    }
  }

  void _onTapLoginButton(){
    Navigator.pop(context);
  }

  Future<void> _signUpUser() async {

    final bool isSuccess = await _signUpProvider.signUpUser(email: _emailTEController.text.trim(), firstName: _firstNameTEController.text.trim(), lastName: _lastNameTEController.text.trim(), mobile: _mobileTEController.text.trim(), password: _passwordTEController.text);

    if(isSuccess){
      _clearTextFeild();
      snackBarMessage(context, "Registration Success! Please login.");
    }else{
      snackBarMessage(context, _signUpProvider.errorMessage!);
    }
    /*
    _signUpInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email":_emailTEController.text.trim(),
      "firstName":_firstNameTEController.text.trim(),
      "lastName":_lastNameTEController.text.trim(),
      "mobile":_mobileTEController.text.trim(),
      "password":_passwordTEController.text
    };


    final ApiResponse response = await ApiCaller.postRequest(
        url: Urls.signUpUrl,
      body: requestBody,
    );

    _signUpInProgress = false;
    setState(() {});

    if(response.isSuccess){
      _clearTextFeild();
      snackBarMessage(context, "Registration Success! Please login.");
    }else{
      snackBarMessage(context, response.errorMessage!);
    }

     */
  }

  void _clearTextFeild(){
    _emailTEController.clear();
    _passwordTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
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


