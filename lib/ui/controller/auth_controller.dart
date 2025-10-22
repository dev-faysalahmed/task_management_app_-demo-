import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/user_model.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';


class AuthController extends ChangeNotifier{

  static const String _accessTokenKey = 'Token';
  static const String _userModelKey = 'user-model';

  static String? accessToken;
  static UserModel? userModel;

  UserModel? get model => userModel;

  static Future<void> saveUserData(UserModel model, String token)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(_userModelKey, jsonEncode(model.toJson()));

    accessToken = token;
    userModel = model;
  }

   Future<void> updateUserData(UserModel model)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userModelKey, jsonEncode(model.toJson()));
    userModel = model;
    notifyListeners();
  }

  static Future<void> getUserData()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString(_accessTokenKey);
    
    if (token != null) {
      String? encodedUserModel = sharedPreferences.getString(_userModelKey);
      userModel = UserModel.fromJson(jsonDecode(encodedUserModel!));
      accessToken = token;
    }
  }

  static Future<bool> isUserAlreadyLoggedIn()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);


    if(token != null){
      return true;
    }
    return false;


  }


  static Future<void> clearUserData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();


  }



}