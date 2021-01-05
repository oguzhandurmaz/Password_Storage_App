import 'package:flutter/material.dart';
import 'package:flutter_password_storage_app/shared/button_match_parent_primary.dart';
import 'package:flutter_password_storage_app/shared/button_match_parent_accent.dart';
import 'package:flutter_password_storage_app/shared/password_text_field.dart';
import 'package:flutter_password_storage_app/utils/constants.dart';
import 'package:flutter_password_storage_app/utils/result.dart';
import 'package:flutter_password_storage_app/validation/ValidationMixin.dart';
import 'package:flutter_password_storage_app/viewmodels/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel(),
          child: Consumer<LoginViewModel>(
            builder: (context, model, child) {
              return buildBody(context, model);
            },
          ),
        ));
  }

  Widget buildBody(context, model) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PasswordTextField(_passwordController, validatePasswordIsEmpty),
              SizedBox(
                height: 8,
              ),
              ButtonMatchParentAccent(
                onPressed: () {
                  login(context);
                },
                text: "Giriş",
              ),
              ButtonMatchParentPrimary(
                onPressed: Constants.prefs.getString("password") != null
                    ? null
                    : signUp,
                text: "Şifre Belirle",
              )
            ],
          ),
        ),
      ),
    );
  }

  void login(context) async {
    if (_formKey.currentState.validate()) {
      var result = await Provider.of<LoginViewModel>(context, listen: false)
          .login(_passwordController.text);
      if (result.runtimeType == SuccessState) {
        Navigator.pushReplacementNamed(context, "/pass");
        //Navigator.pushNamed(context, "/pass");
      }
    }
  }

  void signUp() {
    Navigator.pushNamed(context, "/signup");
  }
}
