
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tronicbanking/Models/user.dart';
import 'package:tronicbanking/services/database.dart';
import 'package:tronicbanking/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:tronicbanking/Models/player.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Todo: make a list of images to choose from.

  String _currentName;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        final players = Provider.of<List<Player>>(context);

        if (snapshot.hasData && loading == false){

          UserData userData = snapshot.data;
          print(snapshot.data.name);

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Colors.transparent,
            child: Stack(
              fit: StackFit.passthrough,
              children:<Widget>[
                Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: const Offset(0.0, 10.0),
                          )]),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 15.0,),
                        Text("Update your name",style: TextStyle(fontSize: 20.0),),
                        SizedBox(height: 25.0,),
                        TextFormField(
                          initialValue: userData.name,
                          decoration: textInputDecoration.copyWith(hintText: "Enter Name") ,
                          validator: (val)=> val.isEmpty ?'Please enter name': null,
                          onChanged: (val)=> setState(()=> _currentName = val),
                        ),
                        SizedBox(height: 15.0),
                        CupertinoButton(
                          child: Text('Submit',style: TextStyle(color: Colors.blue,fontSize: 20.0)),
                          onPressed: () async{
                            if (_formKey.currentState.validate()){
                              await DatabaseService(uid: user.uid).changeUserName(
                                  _currentName ?? userData.name
                              );
                              Navigator.pop(context);
                            }
                          },
                        ),
                        SizedBox(height: 40.0,),
                        Center(
                          child: FlatButton(
                            child: Text("RESET GAME",style: TextStyle(color: Colors.red,fontSize: 20.0),),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.red, width: 2, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(50)
                            ),
                            textColor: Colors.white12,
                            onPressed: () async{
                              setState(() {
                                loading = true;
                              });
                              for (var player in players){
                                print('starting');
                                await DatabaseService(uid: player.userID).changeUserBank(37700000);
                              }
                              setState(() {
                                loading = false;
                              });
                              Navigator.pop(context);

                            },

                          ),
                        )


                      ],
              ),
                    ),
                  ),
                ),
            ]
            ),

          );

        }else{
          return Center(
            child: CupertinoActivityIndicator(
              animating: true,
              radius: 30.0,
            ),
          );

        }

      }
    );
  }
}
