import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tronicbanking/Models/player.dart';
import 'package:tronicbanking/Models/user.dart';

class DatabaseService{
  final String uid;

  DatabaseService({this.uid});

  //collection reference

  final playerCollection = Firestore.instance.collection('players');

  Future createNewUser(String userId, String name, int bankBalance) async{
    return await playerCollection.document(uid).setData({
      'userId': userId,
      'name': name,
      'bankBalance': bankBalance
    });
  }

  Future changeUserBank(int bankBalance) async{
    return await playerCollection.document(uid).updateData({
      'bankBalance': bankBalance
    });
  }
  Future changeUserName(String name) async{
    return await playerCollection.document(uid).updateData({
      'name': name
    });
  }


  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      bankBalance: snapshot.data['bankBalance'],
    );
  }

  //player list from snapshot
  List<Player> _playerListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Player(
        userID: doc.data['userId'] ?? '',
        name: doc.data['name'] ?? '',
        bankBalance: doc.data['bankBalance'] ?? 37700000
      );
    }).toList();
  }

  Stream<List<Player>> get players{
    return playerCollection.snapshots()
        .map(_playerListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return playerCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }


}