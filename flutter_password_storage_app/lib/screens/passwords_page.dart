import 'package:flutter/material.dart';
import 'package:flutter_password_storage_app/models/password.dart';
import 'package:flutter_password_storage_app/shared/button_wrap_parent_accent.dart';
import 'package:flutter_password_storage_app/shared/button_wrap_parent_primary.dart';
import 'package:flutter_password_storage_app/shared/password_list_item.dart';
import 'package:flutter_password_storage_app/utils/result.dart';
import 'package:flutter_password_storage_app/viewmodels/passwords_view_model.dart';
import 'package:provider/provider.dart';

class PasswordsPage extends StatefulWidget {
  @override
  _PasswordsPageState createState() => _PasswordsPageState();
}

class _PasswordsPageState extends State<PasswordsPage> {


  @override
  void initState() {
    super.initState();
    //Get Passwords in Init
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //Provider.of<PasswordsViewModel>(context,listen: false).getPasswords();
      context.read<PasswordsViewModel>().getPasswords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Şifrelerim"),
        ),
        body: Consumer<PasswordsViewModel>(
          builder: (context,model,child){
            var resultType = model.passwordListResult.runtimeType;
            var result = model.passwordListResult;
            if(resultType == SuccessState){
              List<Password> list = (result as SuccessState).value;
              if(list.length > 0){
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      //return buildListItem(list[index]);
                      return PasswordListItem(list[index], edit, delete);
                    });
              }
              return noPasswords();
            }else if(resultType == ErrorState){
              return Text("Error");
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
      ),

    );
  }

  Widget buildListItem(Password item) {
    print(item.platformName);
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
                    blurRadius: 5,)
              ],
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.platformName,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("******************************************",
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      ButtonWrapParentAccent(
                        onPressed: () {},
                        text: Text("Deşifre"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      ButtonWrapParentPrimary(
                        onPressed: () => edit(item),
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
                onTap: (){

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

  Widget noPasswords(){
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Burada Şifre Yok"),
            Text("+ butonuna basarak Şifre ekleyebilirsin")
          ],
        ),
      ),
    );
  }

  void decrypt(int index) {}

  void edit(Password password) async{
    final result = await Navigator.pushNamed(context, "/pass_edit",arguments: password);
    if(result != null && result){
      //Get Password Again - Düzenlenme olduğu için
      context.read<PasswordsViewModel>().getPasswords();
    }

  }

  void delete(int index) {}

  void add() async{
    final result = await Navigator.pushNamed(context, "/pass_add");
    if(result != null && result){
      //Get Password Again - Ekleme olduğu için
      context.read<PasswordsViewModel>().getPasswords();
    }
  }
}
