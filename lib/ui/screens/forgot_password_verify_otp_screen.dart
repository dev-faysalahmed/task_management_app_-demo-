import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management_project/ui/screens/login_screen.dart';
import 'package:task_management_project/ui/screens/reset_password_screen.dart';
import 'package:task_management_project/ui/screens/signup_screen.dart';
import 'package:task_management_project/ui/widgets/screen_background.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgotPasswordVerifyOtpScreen({super.key});

  @override
  State<ForgotPasswordVerifyOtpScreen> createState() => _ForgotPasswordVerifyOtpScreenState();
}

class _ForgotPasswordVerifyOtpScreenState extends State<ForgotPasswordVerifyOtpScreen> {

  final TextEditingController _otpTEController = TextEditingController();
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
                  Text('Enter Your OTP', style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4,),
                  Text('A 6 digit OTP has been sent to your email address.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
                  SizedBox(height: 24,),

                  PinCodeTextField(
                    length: 6,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.black
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    controller: _otpTEController,
                    appContext: context,
                  ),

                  SizedBox(height: 16,),
                  FilledButton(
                      onPressed: _onTapVerifyButton,
                      child: Text('Verify')
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
  
  void _onTapLoginButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),),
        (predicate) => false,
    );

  }
  void _onTapVerifyButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(),), (predicate) => false,);
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
