import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_management_project/ui/controller/auth_controller.dart';
import 'package:task_management_project/ui/screens/login_screen.dart';
import 'package:task_management_project/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_management_project/ui/screens/new_task_screen.dart';
import 'package:task_management_project/ui/utils/assets_paths.dart';
import 'package:task_management_project/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async{
    await Future.delayed(Duration(seconds: 5));
    bool isLoggedIn = await AuthController.isUserAlreadyLoggedIn();
    if(isLoggedIn){
      await AuthController.getUserData();
      Navigator.pushReplacementNamed(context, MainNavBarHolderScreen.name);
    }else{
      Navigator.pushReplacementNamed(context, LoginScreen.name);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Center(child: SvgPicture.asset(AssetsPath.logoSvg, height: 150,))),
    );
  }
}
