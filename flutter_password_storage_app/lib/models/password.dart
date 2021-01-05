class Password{

  int id;
  String platformName;
  String password;

  Password({this.platformName, this.password});
  Password.withId({this.id,this.platformName, this.password});


  Password.fromObject(dynamic o){
    this.id = o["id"];
    this.platformName = o["platformName"];
    this.password = o["password"];
  }

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["platformName"] = platformName;
    map["password"] = password;
    if(id != null){
      map["id"] = id;
    }
    return map;
  }
}