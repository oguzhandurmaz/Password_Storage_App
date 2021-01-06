import 'package:encrypt/encrypt.dart';

class MyEncrypt{

  static MyEncrypt _encrypt;

  static MyEncrypt get myEncrypt {
    if(_encrypt != null){
      return _encrypt;
    }
    var t = MyEncrypt._();
    var temp = t._create();
    _encrypt = temp;
    return _encrypt;
  }

  static Encrypter _encrypter;
  static Key _key;
  static IV _iv;

  MyEncrypt._();

  MyEncrypt _create(){

    if(_encrypt != null){
      return _encrypt;
    }

    var temp = MyEncrypt._();
    _key = Key.fromUtf8("12345678912345678912345678912345");
    _iv = IV.fromLength(16);

    _encrypter = Encrypter(AES(_key));
    _encrypt = temp;
    return _encrypt;


  }

  String encrypt(String value){
    var encrypted =  _encrypter.encrypt(value,iv: _iv);

    return encrypted.base64;

  }

  String decrypt(String value){
    var decrypted = _encrypter.decrypt64(value,iv: _iv);
    return decrypted;
  }



}