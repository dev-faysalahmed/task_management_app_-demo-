import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/ui/controller/recover_verify_email_provider.dart';
import 'package:task_management_project/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:task_management_project/ui/screens/login_screen.dart';
import 'package:task_management_project/ui/screens/signup_screen.dart';
import 'package:task_management_project/ui/widgets/screen_background.dart';
import 'package:task_management_project/ui/widgets/snack_bar_message.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  static const String name = '/verify-email';

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() => _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState extends State<ForgotPasswordVerifyEmailScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RecoverVerifyEmailProvider _recoverVerifyEmailProvider = RecoverVerifyEmailProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _recoverVerifyEmailProvider,
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
                    Text('Your Email Address', style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 4,),
                    Text('A 6 digit OTP will be sent to your email address.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
                    SizedBox(height: 24,),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: 'Email'),),
                    SizedBox(height: 16,),
                    Consumer<RecoverVerifyEmailProvider>(
                      builder: (context, provider, _) {
                        return Visibility(
                          visible: provider.recoverVerifyEmailInProgress == false,
                          replacement: Center(child: CircularProgressIndicator(),),
                          child: FilledButton(
                              onPressed: _onTapNextButton,
                              child: Text('Next')
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

  
  void _onTapLoginButton(){
    Navigator.pop(context);
  }


  void _onTapNextButton(){
    recoverVerifyEmail();
    //Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordVerifyOtpScreen(),));
  }



  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

  Future<void> recoverVerifyEmail()async{
    final bool isSuccess = await _recoverVerifyEmailProvider.emailVerify(_emailTEController.text.trim());

    if(isSuccess){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordVerifyOtpScreen(email: _emailTEController.text.trim()),));
    }else{
      snackBarMessage(context, "check your email and try again");
    }
  }
}
