import 'package:flutter/material.dart';
import 'package:PasswordStorageApp/screens/login_page.dart';
import 'package:PasswordStorageApp/screens/password_add_page.dart';
import 'package:PasswordStorageApp/screens/password_edit_page.dart';
import 'package:PasswordStorageApp/screens/passwords_page.dart';
import 'package:PasswordStorageApp/screens/signup_page.dart';
import 'package:PasswordStorageApp/utils/constants.dart';
import 'package:PasswordStorageApp/viewmodels/passwords_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xfff3722c),
        accentColor: Color(0xfff94144)
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/signup" : (context) => SignUpPage(),
        "/pass_add": (context) => PasswordAddPage(),
        "/pass_edit": (context) => PasswordEditPage(),
        "/pass" : (context) => ChangeNotifierProvider(create: (context) => PasswordsViewModel(),child: PasswordsPage(),)
      },
    );
  }
}
