import 'package:flutter/material.dart';

class ButtonWrapParentPrimary extends StatelessWidget {
  final Function onPressed;
  final Text text;

  ButtonWrapParentPrimary({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        height: 40,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: onPressed,
        child: text);
  }
}
