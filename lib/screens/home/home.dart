import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tronicbanking/screens/home/payment_form.dart';
import 'package:tronicbanking/screens/home/settings_form.dart';
import 'package:tronicbanking/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:tronicbanking/screens/home/players_list.dart';
import 'custom_dialog.dart';
import 'custom_dialog_2.dart';
class Home extends StatelessWidget {

  Future<void> _signOut(BuildContext context) async{
    try{
      final auth = Provider.of<AuthService>(context,listen: false);
      await auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {


    void _showSettingsPanel(){
      showDialog(context: context, builder: (context){
        return Container(
          //padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 40.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child:SettingsForm() ,
          )
        );
      });
    }
    
    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.redAccent,
        middle: Text('Tronic Banking',style: TextStyle(color: Colors.white,fontSize: 17.0,shadows: [Shadow(blurRadius: 5.0,color: Colors.white)])),
        trailing: FlatButton.icon(
            onPressed: () async{
              await _signOut(context);
            },
            icon: Icon(CupertinoIcons.person,size: 22.0,),
            label: Text('Logout',style: TextStyle(fontSize: 12.0),)),
        leading: FlatButton.icon(
            onPressed: (){
              _showSettingsPanel();
            },
            icon: Icon(CupertinoIcons.settings,size: 22.0,),
            label: Text('Settings',style: TextStyle(fontSize: 12.0),)),
      ),
      child: SafeArea(
        child: Stack(

          children: <Widget>[
            Container(
              child: PlayersList(),
            ),
            Positioned(
              bottom: Alignment.bottomLeft.y + 40 ,
              right: Alignment.bottomRight.x + 30,
              child: Container(
                height: 70,
                width: 70,
                child: FloatingActionButton(
                  heroTag: new GlobalObjectKey(FlatButton),
                  child: Icon(Icons.attach_money,size: 30,),
                  backgroundColor: Colors.redAccent,
                  onPressed: (){
                    return showDialog(context: context,
                    builder: (BuildContext context)=> CustomDialog(
                      title: "Sucess",
                      icon: Icon(Icons.account_balance),
                    ));
                  },
                ),
              ),
            ),
            Positioned(
              bottom: Alignment.bottomLeft.y + 40 ,
              left: Alignment.bottomLeft.x + 30,
              child: Container(
                height: 70,
                width: 70,
                child: FloatingActionButton(
                  heroTag: new GlobalObjectKey(FloatingActionButton),
                  child: Icon(Icons.money_off,size: 30,),
                  backgroundColor: Colors.redAccent,
                  onPressed: (){
                    return showDialog(context: context,
                        builder: (BuildContext context)=> CustomDialog2(
                          title: "Sucess",
                        ));
                  },
                ),
              ),
            ),

          ],

        ),
      ),
    );
  }
}
