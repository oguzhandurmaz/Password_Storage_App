import 'package:flutter/material.dart';
import 'package:PasswordStorageApp/database/db_helper.dart';
import 'package:PasswordStorageApp/models/password.dart';
import 'package:PasswordStorageApp/utils/result.dart';

class PasswordsViewModel with ChangeNotifier{

  DbHelper _dbHelper;

  Result _passwordListState;
  Result get passwordListState => _passwordListState;

  Result _passwordDeleteState;
  Result get passwordDeleteState => _passwordDeleteState;

  PasswordsViewModel(){
    _dbHelper = DbHelper();
  }

  void getPasswords() async{
    //Loading State
    _passwordListState = Result.loading("loading");
    notifyListeners();

    print("get Passwords");

    //Get Passwords
    try{
      List<Password> result = await _dbHelper.getPasswords();
      _passwordListState = Result.success(result);

    }catch(error){
      //Error State
      _passwordListState = Result.error("Şifreler alınamadı");
    }
    notifyListeners();
  }

  Future<int> deletePassword(int id) async{
    //Delete Passwords
    try{
      var result = await _dbHelper.delete(id);
      return result;
    }catch(error){
      return 0;
    }
  }
}