import 'package:flutter/foundation.dart';
import 'package:PasswordStorageApp/database/db_helper.dart';
import 'package:PasswordStorageApp/models/password.dart';
import 'package:PasswordStorageApp/utils/result.dart';

class PasswordAddViewModel with ChangeNotifier{

  DbHelper _dbHelper;

  Result _passwordAddResult;
  Result get passwordAddResult => _passwordAddResult;


  PasswordAddViewModel(){
    _dbHelper = DbHelper();
  }

  Future<bool> addPassword(Password password) async{
    //Set Loading
    _passwordAddResult = Result.loading("loading");
    notifyListeners();

    try{
      await _dbHelper.insert(password);
      _passwordAddResult = Result.success("Eklendi");
      notifyListeners();
      return true;
    }catch(error){
      _passwordAddResult = Result.error("Şifre Eklenemedi");
      notifyListeners();
      return false;
    }


  }


}