import 'package:flutter/material.dart';
import 'package:flutter_password_storage_app/database/db_helper.dart';
import 'package:flutter_password_storage_app/models/password.dart';
import 'package:flutter_password_storage_app/utils/result.dart';

class PasswordsViewModel with ChangeNotifier{

  DbHelper _dbHelper;

  Result _passwordListResult;
  Result get passwordListResult => _passwordListResult;

  PasswordsViewModel(){
    _dbHelper = DbHelper();
  }

  void getPasswords() async{
    //Loading State
    _passwordListResult = Result.loading("loading");
    notifyListeners();

    print("get Passwords");

    //Get Passwords
    try{
      List<Password> result = await _dbHelper.getPasswords();
      _passwordListResult = Result.success(result);

    }catch(error){
      //Error State
      _passwordListResult = Result.error("Şifreler alınamadı");
    }
    notifyListeners();
  }
}