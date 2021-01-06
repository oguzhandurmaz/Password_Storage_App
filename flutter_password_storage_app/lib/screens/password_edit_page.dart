import 'package:PasswordStorageApp/models/password.dart';
import 'package:PasswordStorageApp/shared/button_match_parent_accent.dart';
import 'package:PasswordStorageApp/shared/password_text_field.dart';
import 'package:PasswordStorageApp/utils/my_encrypt.dart';
import 'package:PasswordStorageApp/validation/ValidationMixin.dart';
import 'package:PasswordStorageApp/viewmodels/password_edit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordEditPage extends StatefulWidget {
  @override
  _PasswordEditPageState createState() => _PasswordEditPageState();
}

class _PasswordEditPageState extends State<PasswordEditPage>
    with ValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _platformController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Get Args
    final Password args = ModalRoute.of(context).settings.arguments;

    //Set TextField Text
    _platformController.text = args.platformName;
    //_passwordController.text = MyEncrypt.myEncrypt.decrypt(args.password);

    return Scaffold(
        appBar: AppBar(
          title: Text("Şifre Düzenle"),
        ),
        body: ChangeNotifierProvider(
          create: (context) => PasswordEditViewModel(),
          child: Consumer<PasswordEditViewModel>(
            builder: (context, model, child) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 16, 8, 0),
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
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        PasswordTextField(_passwordController, validatePasswordIsEmpty),
                        SizedBox(
                          height: 8,
                        ),
                        ButtonMatchParentAccent(
                            onPressed: () => edit(context, args.id),
                            text: "Düzenle")
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  void edit(context, int id) async {
    if(_formKey.currentState.validate()){
      var password = Password.withId(id:id, platformName: _platformController.text,password: _passwordController.text);
      var result = await Provider.of<PasswordEditViewModel>(context,listen: false).edit(password);
      if(result){
        Navigator.pop(context,true);
      }
    }
  }
}
