

import 'package:flutter/material.dart';
import 'package:PasswordStorageApp/utils/constants.dart';
import 'package:PasswordStorageApp/utils/result.dart';

class SignupViewModel with ChangeNotifier{

  Result _signUpState;
  Result get signUpState => _signUpState;

  Future<bool> signUp(String password) async{
    //Set Loading
    _signUpState = Result.loading("loading");
    notifyListeners();

    //Save to SharedPreferences
    bool result = await Constants.prefs.setString("password", password);
    if(result){
      return result;
    }

    //Error State
    _signUpState = Result.error("Kayıt yapılamadı");
    notifyListeners();

    return result;


  }

}