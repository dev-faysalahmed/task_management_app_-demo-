import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key, required this.chipTitle, required this.chipColor,
  });

  final String chipTitle;
  final Color chipColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.white,
      title: Text('Title will be here'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text('Subtitle will be here.....'),
          Text('Date: 12/12/2025', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
          Row(children: [
            Chip(label: Text(chipTitle, style: TextStyle(color: Colors.white),), backgroundColor: chipColor ?? Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), padding: EdgeInsets.symmetric(horizontal: 16),),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,)),
            IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.grey,)),
          ],),
        ],
      ),
    );
  }
}