import 'package:PasswordStorageApp/models/password.dart';
import 'package:PasswordStorageApp/utils/my_encrypt.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  Database _database;

  Future<Database> get database  async{
    if(_database == null){
      _database =  await initilazeDb();
      return _database;
    }
    return _database;
  }

  Future<Database> initilazeDb() async{
    String dbPath = join(await getDatabasesPath(),"platfrom_passwords.db");
    var passDb = await openDatabase(dbPath,version: 1,onCreate: createDb);
    return passDb;
  }

  Future<void> createDb(Database db, int version) async{
    await db.execute("Create table passwords(id integer primary key, platformName text,password text)");
  }

  Future<List<Password>> getPasswords() async{
    var db = await this.database;
    var result = await db.query("passwords");
    return List.generate(result.length, (i){
      return Password.fromObject(result[i]);
    });
  }

  Future<Password> getPassword(int id) async{
    var db = await this.database;
    //var result = await db.rawQuery("select * from passwords where id= $id");
    var result = await db.query("passwords",where: "id=?",whereArgs: [id],limit: 1);
    return Password.fromObject(result);
  }

  Future<int> insert(Password password) async{
    var db = await this.database;

    //Encrypt password
    password.password = MyEncrypt.myEncrypt.encrypt(password.password);

    var result = await db.insert("passwords", password.toMap());
    return result;
  }

  Future<int> delete(int id) async{
    var db = await this.database;
    var result = await db.rawDelete("delete from passwords where id= $id");
    return result;
  }

  Future<int> update(Password password) async{
    var db = await this.database;

    //Encrypt password
    password.password = MyEncrypt.myEncrypt.encrypt(password.password);
    var a = MyEncrypt.myEncrypt.decrypt(password.password);
    var result = await db.update("passwords", password.toMap(),where: "id=?",whereArgs: [password.id]);
    return result;
  }
}