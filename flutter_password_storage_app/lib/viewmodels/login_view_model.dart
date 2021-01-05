import 'package:flutter/material.dart';
import 'package:flutter_password_storage_app/utils/constants.dart';
import 'package:flutter_password_storage_app/utils/result.dart';

class LoginViewModel with ChangeNotifier{

  Result _loginState;

  Result get loginState => _loginState;

  Future<Result> login(String password) async{
    //Loading
    _loginState = Result.loading("loading");
    notifyListeners();

    //Check State
    var passwordInApp = Constants.prefs.getString("password");
    if(passwordInApp == password){
      _loginState = Result.success(true);
      notifyListeners();
      return _loginState;
    }

    _loginState = Result.error("Şifre yanlış");
    return _loginState;


  }

}