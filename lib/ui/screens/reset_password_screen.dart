import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/ui/controller/recover_reset_password_provider.dart';
import 'package:task_management_project/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:task_management_project/ui/screens/login_screen.dart';
import 'package:task_management_project/ui/screens/signup_screen.dart';
import 'package:task_management_project/ui/widgets/screen_background.dart';
import 'package:task_management_project/ui/widgets/snack_bar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RecoverResetPasswordProvider _recoverResetPasswordProvider = RecoverResetPasswordProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _recoverResetPasswordProvider,
      child: Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 82,),
                    Text('Reset Password', style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 4,),
                    Text('Password should be 6 later and combination of number.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
                    SizedBox(height: 24,),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: 'New Password'),
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      validator: (String? value) {
                        if(value?.length != 6){
                          return "Enter your 6 digit password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _confirmPasswordTEController,
                      obscureText: true,
                        textInputAction: TextInputAction.done,
                      decoration: InputDecoration(hintText: 'Confirm Password'),
                      validator: (String? value) {
                        if(value?.length != 6){
                          return "Enter your 6 digit password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),
                    FilledButton(
                        onPressed: _onTapConfirmButton,
                        child: Text('Confirm'),
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

  void _onTapLoginButton() {
    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => LoginScreen(),),
          (predicate) => false,
    );
  }

  void _onTapConfirmButton(){
    if(_formKey.currentState!.validate()){
      if(_passwordTEController.text == _confirmPasswordTEController.text){
        setNewPassword(_passwordTEController.text);
      }else{
        snackBarMessage(context, 'New Password and Confirm Password not match');
      }
    }
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }

  Future<void> setNewPassword(String password)async{
    final bool isSuccess = await _recoverResetPasswordProvider.resetPassword(widget.email, widget.otp, password);

    if(isSuccess){
      Navigator.pushNamed(context, LoginScreen.name);
    }else{
      snackBarMessage(context, "Failed! try again later.");
    }
  }
}
