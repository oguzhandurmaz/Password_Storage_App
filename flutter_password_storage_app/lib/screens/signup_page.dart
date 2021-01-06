import 'package:flutter/material.dart';
import 'package:PasswordStorageApp/shared/button_match_parent_accent.dart';
import 'package:PasswordStorageApp/shared/password_again_text_field.dart';
import 'package:PasswordStorageApp/shared/password_text_field.dart';
import 'package:PasswordStorageApp/utils/result.dart';
import 'package:PasswordStorageApp/validation/ValidationMixin.dart';
import 'package:PasswordStorageApp/viewmodels/signup_view_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with ValidationMixin {
  var _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Şifre Belirle"),
        ),
        body: ChangeNotifierProvider(
          create: (context) => SignupViewModel(),
          child: Consumer<SignupViewModel>(
            builder: (context,model,child){
              return Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PasswordTextField(_passwordController, validatePassword),
                        SizedBox(
                          height: 8,
                        ),
                        PasswordAgainTextField(_passwordAgainController,
                            _passwordController, validatePasswordsSame),
                        SizedBox(
                          height: 16,
                        ),
                        ButtonMatchParentAccent(
                          onPressed: () => signUp(context),
                          text: "Şifre Belirle",
                        ),
                        loading(model)
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        )
    );
  }

  void signUp(context) async {
    if (_formKey.currentState.validate()) {
      bool result = await Provider.of<SignupViewModel>(context, listen: false)
          .signUp(_passwordController.text);

      if(result){
        print(result);
        Navigator.pop(context);
      }

    }
  }

  Widget loading(SignupViewModel model){
    if( model.signUpState.runtimeType == LoadingState){
      return Text("Loading");
    }
    return Container();
  }
}
