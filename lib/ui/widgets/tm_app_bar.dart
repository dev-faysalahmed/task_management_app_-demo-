import 'package:flutter/material.dart';
import 'package:task_management_project/ui/screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key, this.fromUpdateProfile,
  });

  final bool? fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: (){
          if(fromUpdateProfile ?? false){
            return;
          }
          Navigator.pushNamed(context, UpdateProfileScreen.name);
        },
        child: Row(
          spacing: 8,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/faysal_ahmed.jpg'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Faysal Ahmed', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                Text('Mobile App Developer', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.logout, color: Colors.white,))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}


