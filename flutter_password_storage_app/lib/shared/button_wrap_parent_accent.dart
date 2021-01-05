import 'package:flutter/material.dart';

class ButtonWrapParentAccent extends StatelessWidget {
  final Function onPressed;
  final Text text;

  ButtonWrapParentAccent({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        height: 40,
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        onPressed: onPressed,
        child: text);
  }
}
