import 'dart:async';

import 'package:flutter/material.dart';
import 'package:PasswordStorageApp/models/password.dart';

import 'button_wrap_parent_accent.dart';
import 'button_wrap_parent_primary.dart';

class PasswordListItem extends StatefulWidget {
  Password password;
  Function(Password) edit;
  Function(int) delete;

  PasswordListItem(this.password, this.edit, this.delete);

  @override
  _PasswordListItemState createState() =>
      _PasswordListItemState(password, edit, delete);
}

class _PasswordListItemState extends State<PasswordListItem> {
  Password password;
  Function(Password) edit;
  Function(int) delete;

  final timeout = Duration(seconds: 3);
  Timer _timer;


  String pass = "*********************";
  String dots = "*********************";

  bool isEncrypted = true;

  _PasswordListItemState(this.password, this.edit, this.delete);

  @override
  void dispose() {
    if(_timer != null){
      _timer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(password.platformName);
    return Stack(
      key: UniqueKey(),
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
                            if(isEncrypted){
                              pass = dots;

                              if(_timer != null){
                                _timer.cancel();
                              }

                            }else{
                              //Start Time out for encrypt again
                              startTimeOut();
                              pass = password.password;
                            }
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
                onTap: () => delete(password.id),
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

  void startTimeOut(){
    _timer = Timer(timeout, (){
      setState(() {
        isEncrypted = !isEncrypted;
        pass = dots;
      });
    });
  }

  void handleTimeout() {

  }
}
