import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController _controller;
  final Function(String) _validator;

  PasswordTextField(this._controller, this._validator);

  @override
  _PasswordTextFieldState createState() =>
      _PasswordTextFieldState(_controller, _validator);
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  final TextEditingController _controller;
  final Function(String) _validator;

  _PasswordTextFieldState(this._controller, this._validator);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: _obscureText,
      validator: _validator,
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
          labelText: "Şifre"),
    );
  }
}
