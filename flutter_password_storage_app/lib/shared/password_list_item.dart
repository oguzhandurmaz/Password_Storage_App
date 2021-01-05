import 'package:flutter/material.dart';
import 'package:flutter_password_storage_app/models/password.dart';

import 'button_wrap_parent_accent.dart';
import 'button_wrap_parent_primary.dart';

class PasswordListItem extends StatefulWidget {
  final Password password;
  final Function(Password) edit;
  final Function(int) delete;

  PasswordListItem(this.password, this.edit, this.delete);

  @override
  _PasswordListItemState createState() =>
      _PasswordListItemState(password, edit, delete);
}

class _PasswordListItemState extends State<PasswordListItem> {
  Password password;
  final Function(Password) edit;
  final Function(int) delete;

  String pass = "*********************";
  String dots = "*********************";

  bool isEncrypted = true;

  _PasswordListItemState(this.password, this.edit, this.delete);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      children: [
        Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Theme.of(context).accentColor,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange[100].withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                )
              ],
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    password.platformName,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(pass,
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      ButtonWrapParentAccent(
                        onPressed: () {
                          //Decrypt
                          setState(() {
                            isEncrypted = !isEncrypted;
                            pass = isEncrypted ? dots : password.password;

                          });
                        },
                        text: Text("Deşifre"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ButtonWrapParentPrimary(
                        onPressed: () => edit(password),
                        text: Text("Düzenle"),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        Positioned(
          child: Transform.rotate(
              angle: -40,
              child: InkWell(
                onTap: () {
                  //delete
                },
                child: Icon(
                  Icons.add_circle,
                  size: 36,
                  color: Theme.of(context).accentColor,
                ),
              )),
          right: 0,
          top: 0,
        ),
      ],
    );
  }
}
