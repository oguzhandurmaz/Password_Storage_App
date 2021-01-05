import 'package:flutter/material.dart';
import 'package:flutter_password_storage_app/database/db_helper.dart';
import 'package:flutter_password_storage_app/models/password.dart';
import 'package:flutter_password_storage_app/utils/result.dart';

class PasswordEditViewModel with ChangeNotifier{

  DbHelper _dbHelper;

  Result _passwordEditState;
  Result get passwordEditState => _passwordEditState;


  PasswordEditViewModel(){
    _dbHelper = DbHelper();
  }

  Future<bool> edit(Password password) async{
    //Loading State
    _passwordEditState = Result.loading("asd");
    notifyListeners();

    //Edit
    try{
      var result = await _dbHelper.update(password);
      _passwordEditState = Result.success(result);
      notifyListeners();
      return true;

    }catch(error){
     _passwordEditState = Result.error("Şifre Değiştirilemedi");
     notifyListeners();
     return false;
    }
  }
}