import 'package:flutter/material.dart';

class ButtonWrapParentFlat extends StatelessWidget {

final Function onPressed;
final Text text;

ButtonWrapParentFlat({this.onPressed, this.text});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        height: 40,
        textColor: Theme.of(context).accentColor,
        onPressed: onPressed,
        child: text);
  }
}
