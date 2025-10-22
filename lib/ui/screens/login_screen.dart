import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/ui/controller/login_provider.dart';
import 'package:task_management_project/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_management_project/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_management_project/ui/screens/signup_screen.dart';
import 'package:task_management_project/ui/widgets/circular_progress.dart';
import 'package:task_management_project/ui/widgets/screen_background.dart';
import 'package:task_management_project/ui/widgets/snack_bar_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final LoginProvider _loginProvider = LoginProvider();

  bool _passwordIsNotVisiblity = true;
  Icon? _passIcon;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _loginProvider,
      child: Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 82,),
                    Text('Get Started With', style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 24,),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: 'Email'),
                      textInputAction: TextInputAction.next,
                      validator: (String? value) {
                        if(EmailValidator.validate(value!.trim().toString()) == false){
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: _passwordIsNotVisiblity,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                            onTap: _onTapPasswordSuffixIcon,
                              child: _passIcon ?? Icon(Icons.visibility),
                          ),
                          hintText: 'Password'
                      ),
                      validator: (String? value) {
                        if((value?.length ?? 0) != 6){
                          return "Enter minimum 6 digit password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, _) {
                        return Visibility(
                          visible: loginProvider.loginInProgress == false,
                          replacement: circularProgress(),
                          child: FilledButton(
                              onPressed: _onTapLoginButton,
                              child: Icon(Icons.arrow_circle_right_outlined)
                          ),
                        );
                      }
                    ),
                    SizedBox(height: 36,),
                    Center(
                      child: Column(
                        children: [
                          TextButton(onPressed: _onTapForgotPasswordButton, child: Text('Forgot Password?', style: TextStyle(color: Colors.grey),)),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                            text: "Don't have an account? ",
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(color: Colors.green,),
                                recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton,


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
  
  void _onTapSignUpButton(){
    Navigator.pushNamed(context, SignUpScreen.name);
  }
  void _onTapForgotPasswordButton(){
    Navigator.pushNamed(context, ForgotPasswordVerifyEmailScreen.name);
  }

  void _onTapLoginButton(){

    if(_formKey.currentState!.validate()){
      _loginUser();
    }
  }

  Future<void> _loginUser() async{
    final bool isSuccess = await _loginProvider.loginUser(_emailTEController.text.trim(), _passwordTEController.text);

    if(isSuccess){
      Navigator.pushNamedAndRemoveUntil(context, MainNavBarHolderScreen.name, (predicate)=>false);
    }else{
      snackBarMessage(context, _loginProvider.errorMessage!);
    }

  }

  _onTapPasswordSuffixIcon(){
    if(_passwordIsNotVisiblity == true){
      _passwordIsNotVisiblity = false;
      _passIcon = Icon(Icons.visibility_off);
      setState(() {});
    }else{
      _passwordIsNotVisiblity = true;
      _passIcon = Icon(Icons.visibility);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
