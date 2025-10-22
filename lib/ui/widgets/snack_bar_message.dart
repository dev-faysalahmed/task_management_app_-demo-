import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void snackBarMessage(BuildContext context, String sms){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(sms)));
}