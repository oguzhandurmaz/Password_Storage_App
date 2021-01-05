import 'package:flutter/material.dart';

class ButtonMatchParentPrimary extends StatelessWidget {
  final Function onPressed;
  final String text;

  ButtonMatchParentPrimary({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        minWidth: MediaQuery.of(context).size.width,
        height: 40,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(text.toUpperCase()));
  }
}
