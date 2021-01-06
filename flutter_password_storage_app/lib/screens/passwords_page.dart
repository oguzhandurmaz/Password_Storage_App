import 'package:flutter/material.dart';
import 'package:PasswordStorageApp/models/password.dart';
import 'package:PasswordStorageApp/shared/button_wrap_parent_accent.dart';
import 'package:PasswordStorageApp/shared/button_wrap_parent_flat.dart';
import 'package:PasswordStorageApp/shared/button_wrap_parent_primary.dart';
import 'package:PasswordStorageApp/shared/password_list_item.dart';
import 'package:PasswordStorageApp/utils/result.dart';
import 'package:PasswordStorageApp/viewmodels/passwords_view_model.dart';
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
            var resultType = model.passwordListState.runtimeType;
            var result = model.passwordListState;
            if(resultType == SuccessState){
              List<Password> list = (result as SuccessState).value;
              if(list.length > 0){
                return ListView.builder(
                  key: UniqueKey(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      //return buildListItem(list[index]);
                      return new PasswordListItem(list[index], edit, showDeleteDialog);
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

  void edit(Password password) async{
    final result = await Navigator.pushNamed(context, "/pass_edit",arguments: password);
    print(result);
    if(result != null && result){
      //Get Password Again - Düzenlenme olduğu için
      Provider.of<PasswordsViewModel>(context,listen: false).getPasswords();
    }

  }

  Future<void> delete(int id) async{
    var result = await Provider.of<PasswordsViewModel>(context,listen: false).deletePassword(id);
    if(result != 0){
      context.read<PasswordsViewModel>().getPasswords();
    }
  }

  void showDeleteDialog(int id){
    //Show Alert Dialog
    showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Şifre Silme"),
        content: Text("Emin misiniz?"),
        actions: [
          ButtonWrapParentFlat(onPressed: () async{
            await delete(id);
            Navigator.pop(context);
          },text: Text("Evet"),),
          ButtonWrapParentFlat(onPressed: (){
            Navigator.pop(context);
          },text: Text("Hayır"),),
        ],
      );
    });

  }

  void add() async{
    final result = await Navigator.pushNamed(context, "/pass_add");
    if(result != null && result){
      //Get Password Again - Ekleme olduğu için
      context.read<PasswordsViewModel>().getPasswords();
    }
  }
}
