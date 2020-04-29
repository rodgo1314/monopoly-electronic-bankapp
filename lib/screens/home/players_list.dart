import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tronicbanking/Models/player.dart';
import 'package:tronicbanking/screens/home/player_tile.dart';
import 'package:tronicbanking/screens/home/paying_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:tronicbanking/Models/user.dart';


class PlayersList extends StatefulWidget {
  @override
  _PlayersListState createState() => _PlayersListState();
}

class _PlayersListState extends State<PlayersList> {
  @override
  Widget build(BuildContext context) {

    final players = Provider.of<List<Player>>(context) ?? [];
    final user = Provider.of<UserData>(context);



    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context,index) {
        return GestureDetector(
            onTap: () {

              if (user.uid == players[index].userID) {



                showDialog(context: context, child: CupertinoAlertDialog(
                  title: Text("Can't Pay Yourself!"),
                  actions: <Widget>[CupertinoDialogAction(
                    child: Text('Close'),
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('Close');
                    },
                  )
                  ],
                ));
              } else if (user.uid != players[index].userID) {

                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => Paying(index: index,currentUserData: user)));
              }
            },
            child: PlayerTile(player: players[index])
        );
      },
    );
  }
}
