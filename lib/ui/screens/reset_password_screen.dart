import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_project/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:task_management_project/ui/screens/login_screen.dart';
import 'package:task_management_project/ui/screens/signup_screen.dart';
import 'package:task_management_project/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text('Password should be more than 6 later and combination of number.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
                  SizedBox(height: 24,),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(hintText: 'New Password'),),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    decoration: InputDecoration(hintText: 'Confirm Password'),),
                  SizedBox(height: 16,),
                  FilledButton(
                      onPressed: _onTapConfirmButton,
                      child: Text('Confirm')
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
    );
  }

  void _onTapLoginButton() {
    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => LoginScreen(),),
          (predicate) => false,
    );
  }

  void _onTapConfirmButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
