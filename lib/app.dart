import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/ui/controller/auth_controller.dart';
import 'package:task_management_project/ui/controller/login_provider.dart';
import 'package:task_management_project/ui/controller/new_task_list_provider.dart';
import 'package:task_management_project/ui/controller/task_status_count_provider.dart';
import 'package:task_management_project/ui/controller/update_profile_provider.dart';
import 'package:task_management_project/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_management_project/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:task_management_project/ui/screens/login_screen.dart';
import 'package:task_management_project/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_management_project/ui/screens/signup_screen.dart';
import 'package:task_management_project/ui/screens/splash_screen.dart';
import 'package:task_management_project/ui/screens/update_profile_screen.dart';

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewTaskListProvider(),),
        ChangeNotifierProvider(create: (context) => TaskStatusCountProvider(),),
        ChangeNotifierProvider(create: (context) => UpdateProfileProvider(),),
        ChangeNotifierProvider(create: (context) => AuthController(),),
      ],
      child: MaterialApp(
        navigatorKey: navigator,
        theme: ThemeData(
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            )
          ),
          colorSchemeSeed: Colors.green,
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        ),
        initialRoute: SplashScreen.name,
        routes: {
          SplashScreen.name : (_)=>SplashScreen(),
          LoginScreen.name : (_)=>LoginScreen(),
          SignUpScreen.name : (_)=>SignUpScreen(),
          MainNavBarHolderScreen.name : (_)=>MainNavBarHolderScreen(),
          UpdateProfileScreen.name : (_)=>UpdateProfileScreen(),
          ForgotPasswordVerifyEmailScreen.name : (_)=>ForgotPasswordVerifyEmailScreen(),
        },
      
      ),
    );
  }
}