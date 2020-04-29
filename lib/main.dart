import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tronicbanking/auth_widget_builder.dart';
import 'package:tronicbanking/screens/wrapper.dart';
import 'package:tronicbanking/services/auth.dart';
import 'package:tronicbanking/Models/user.dart';
import 'package:tronicbanking/Models/player.dart';
import 'package:tronicbanking/services/database.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers:[
      Provider<AuthService>(
        create: (_)=> AuthService(),
      ),
    ],
      child: AuthWidgetBuilder(builder: (context, userSnapshot){
      return StreamProvider<List<Player>>.value(
        value: DatabaseService().players,
        child: MaterialApp(
          home: Wrapper(userSnapshot: userSnapshot,),
            ),
      );
        }
      )
    );
  }
}


//GestureDetector(
//onTap: (){
//FocusScopeNode currentFocus = FocusScope.of(context);
//if(!currentFocus.hasPrimaryFocus){
//currentFocus.unfocus();
//}
//},

