import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tronicbanking/Models/player.dart';
import 'package:intl/intl.dart';
import 'package:tronicbanking/screens/home/paying_page.dart';

class PlayerTile extends StatelessWidget {
  final Player player;

  PlayerTile({this.player});

  var balanceFormatter = NumberFormat("\$#,###,###",'en_US');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.green,
          ),
          title: Text('${player.name}'),
          subtitle: Text( "Balance: ${balanceFormatter.format( player.bankBalance)}"),

        ),

      ),
    );
  }
}
