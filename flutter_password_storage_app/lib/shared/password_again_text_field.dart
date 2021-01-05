import 'package:flutter/material.dart';

class PasswordAgainTextField extends StatefulWidget {
  final TextEditingController _controller;
  final TextEditingController _controllerAgain;
  final Function(String,String) _validator;

  PasswordAgainTextField(this._controller,this._controllerAgain,this._validator);

  @override
  _PasswordAgainTextFieldState createState() =>
      _PasswordAgainTextFieldState(_controller,_controllerAgain, _validator);
}

class _PasswordAgainTextFieldState extends State<PasswordAgainTextField> {
  bool _obscureText = true;

  final TextEditingController _controller;
  final TextEditingController _controllerAgain;
  final Function(String,String) _validator;

  _PasswordAgainTextFieldState(this._controller,this._controllerAgain, this._validator);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: _obscureText,
      validator: (value){
        return _validator(value,_controllerAgain.text);
      },
      decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText ? Icons.remove_red_eye_sharp : Icons.remove_red_eye),
          ),
          border: OutlineInputBorder(),
          labelText: "Şifre Tekrar"),
    );
  }
}
