class ValidationMixin{

  String validatePassword(String password){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    if(!RegExp(pattern).hasMatch(password) && password.length < 8){
      return "Şifre en az 1 büyük, 1 küçük karakter,1 özel karakter içermelidir. Uzunluk en az 8 karakter olmalıdır";
    }
    return null;
  }

  String validatePasswordsSame(String password,String passwordAgain){
    if(password != passwordAgain){
      return "Şifreler aynı değil.";
    }
    return null;
  }

  String validatePasswordIsEmpty(String password){
    if(password.isEmpty){
      return "Şifre boş bırakılamaz";
    }
    return null;
  }

  String validatePlatform(String name){
    if(name.length < 4 || name.length > 70){
      return "Platfro ismi en az 4, en fazla 70 karakter olabilir";
    }
    return null;
  }
}