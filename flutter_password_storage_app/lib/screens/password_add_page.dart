
import 'package:flutter/material.dart';
import 'package:PasswordStorageApp/models/password.dart';
import 'package:PasswordStorageApp/shared/button_match_parent_accent.dart';
import 'package:PasswordStorageApp/shared/password_again_text_field.dart';
import 'package:PasswordStorageApp/shared/password_text_field.dart';
import 'package:PasswordStorageApp/validation/ValidationMixin.dart';
import 'package:PasswordStorageApp/viewmodels/password_add_view_model.dart';
import 'package:provider/provider.dart';

class PasswordAddPage extends StatefulWidget {
  @override
  _PasswordAddPageState createState() => _PasswordAddPageState();
}

class _PasswordAddPageState extends State<PasswordAddPage>  with ValidationMixin{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _platformController = TextEditingController();
  final TextEditingController _passwordController= TextEditingController();
  final TextEditingController _passwordAgainController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şifre Ekle"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => PasswordAddViewModel(),
        child: Consumer<PasswordAddViewModel>(
          builder: (context,model,child){
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(8,16,8,0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _platformController,
                        validator: validatePlatform,
                        decoration: InputDecoration(
                            labelText: "Platform İsmi",
                            border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 16,),
                      PasswordTextField(_passwordController,validatePasswordIsEmpty),
                      SizedBox(height: 8,),
                      PasswordAgainTextField(_passwordAgainController, _passwordController, validatePasswordsSame),
                      SizedBox(height: 8,),
                      ButtonMatchParentAccent(onPressed: () => add(context),text:"Ekle")
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
    );

  }

  void add(context) async{
    if(_formKey.currentState.validate()){
      var password = Password(platformName: _platformController.text,password: _passwordController.text);
      bool result =  await Provider.of<PasswordAddViewModel>(context,listen: false).addPassword(password);
      if(result){
        Navigator.pop(context,true);
      }
    }
  }
}
