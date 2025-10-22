import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_project/ui/controller/auth_controller.dart';
import 'package:task_management_project/ui/screens/login_screen.dart';
import 'package:task_management_project/ui/screens/update_profile_screen.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key, this.fromUpdateProfile,
  });

  final bool? fromUpdateProfile;

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TMAppBarState extends State<TMAppBar> {

  final profilePhoto = AuthController.userModel!.photo;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      title: Consumer<AuthController>(
        builder: (context, authController, _) {
          return GestureDetector(
            onTap: (){
              if(widget.fromUpdateProfile ?? false){
                return;
              }
              Navigator.pushNamed(context, UpdateProfileScreen.name);
            },
            child: Row(
              spacing: 8,
              children: [
                CircleAvatar(
                  backgroundImage: authController.model!.photo.isNotEmpty ? MemoryImage(base64Decode(profilePhoto)) : null,
                  child: authController.model!.photo.isNotEmpty ? null : Icon(Icons.person, size: 40),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(authController.model?.fullName ?? '', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                    Text(authController.model?.email ?? '', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
                  ],
                ),
              ],
            ),
          );
        }
      ),
      actions: [
        IconButton(onPressed: _signOut, icon: Icon(Icons.logout, color: Colors.white,))
      ],
    );
  }

  Future<void> _signOut()async{
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.name, (predicate)=> false);
  }
}


