import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tronicbanking/screens/authenticate/authenticate.dart';
import 'package:tronicbanking/screens/home/home.dart';
import 'package:tronicbanking/Models/user.dart';
import 'package:tronicbanking/shared/loading.dart';
import 'package:tronicbanking/Models/player.dart';
import 'package:tronicbanking/services/database.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;
  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active){
      return userSnapshot.hasData ? Home() : Authenticate();
    }
    return Loading();
    
  }
}
