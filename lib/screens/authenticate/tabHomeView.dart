import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tronicbanking/Models/user.dart';
import 'package:tronicbanking/screens/authenticate/register.dart';
import 'package:tronicbanking/screens/authenticate/sign_in.dart';
import 'package:tronicbanking/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:tronicbanking/Models/player.dart';
class TabHomeView extends StatefulWidget {
  @override
  _TabHomeViewState createState() => _TabHomeViewState();
}

class _TabHomeViewState extends State<TabHomeView> {

  int state = 0;
  final AuthService _auth = AuthService();

  Widget newContainer = SignIn();

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<List<Player>>(context);


    return CupertinoTabScaffold(
      backgroundColor: Colors.red[50],

      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            title: Text('Sign In'),
            icon: Icon(
              CupertinoIcons.group
            )
          ),
          BottomNavigationBarItem(
            title: Text('Register'),
            icon: Icon(CupertinoIcons.person_add)
          )
        ],
        currentIndex: state,
        onTap: (int index){
          setState(() {
            state = index;
          });
          if (index==0){
            newContainer = SignIn();
          }else{
            newContainer = Register();
          };
        },
      ),

      tabBuilder: (BuildContext context, int index) {

          return CupertinoTabView(
            builder: (BuildContext context){
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: Colors.redAccent,
                  middle: Text('Lets Play Monopoly',style: TextStyle(color: Colors.white,fontSize: 20.0,shadows: [Shadow(blurRadius: 5.0,color: Colors.white)]),),
                ),
                child: SafeArea(
                  child: Card(child: newContainer)
                ),
              );
            },
          );
      },
    );


  }

}
