import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tronicbanking/Models/player.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tronicbanking/Models/user.dart';
import 'package:tronicbanking/shared/constants.dart';
import 'package:tronicbanking/services/database.dart';

class Paying extends StatefulWidget {
  final int index;
  final UserData currentUserData;

  Paying({this.index,this.currentUserData});

  @override
  _PayingState createState() => _PayingState();
}

class _PayingState extends State<Paying> {


  var balanceFormatter = NumberFormat("\$#,###,###", 'en_US');
  final _formKey = GlobalKey<FormState>();

  String paymentAmount;
  String subtractAmount;

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<List<Player>>(context) ?? [];
    final player = players[widget.index];



    void _showPaymentForm() {
      showDialog(context: context, builder: (context) {
        return Container(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 40.0),
            child: Dialog(
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
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Enter Payment Amount",
                              style: TextStyle(fontSize: 20.0),),
                            SizedBox(height: 25.0,),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: "\$0.00"),
                              validator: (val) =>
                              val.isEmpty
                                  ? 'Please enter amount'
                                  : null,
                              onChanged: (val) => setState(() => paymentAmount = val),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 15.0),
                            CupertinoButton(
                              child: Text('Submit',
                                  style: TextStyle(color: Colors.blue, fontSize: 20.0)),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {

                                  await DatabaseService(uid: player.userID)
                                      .changeUserBank(
                                      (player.bankBalance + int.parse(paymentAmount))  ?? player.bankBalance
                                  );
                                  await DatabaseService(uid: widget.currentUserData.uid)
                                      .changeUserBank(
                                      (widget.currentUserData.bankBalance - int.parse(paymentAmount)) ?? widget.currentUserData.bankBalance
                                  );
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                ),]
              ),
            )
        );
      }
      );
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Tronic Banking',
            style: TextStyle(color: Colors.white,fontSize: 20.0,shadows: [Shadow(blurRadius: 5.0,color: Colors.white)])),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                child:Icon(Icons.business,size: 40.0,color: Colors.redAccent,),
                radius: 50.0,
                backgroundColor: Colors.red[50],),
              SizedBox(height: 16.0,)
            ],
          ) ,
        ),
      ),
      body: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 30.0,),

              SizedBox(height: 20.0,),
              Text(player.name,
                style: TextStyle(fontSize: 25.0,color: Colors.black)),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text("Balance:",style: TextStyle(fontSize: 25.0,)),
                SizedBox(width: 10.0,),
                Text("${balanceFormatter.format(player.bankBalance)}",
                    style: TextStyle(fontSize: 25.0,color: Colors.green))
              ],),
              SizedBox(height: 30.0,),
               Card(
                 elevation: 5.0,
                 child: CupertinoButton(
                   padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
                  child: Text("Pay",style: TextStyle(fontSize: 25.0,color: Colors.blue),),
                  onPressed: (){
                    _showPaymentForm();
                  },


              ),
               )

            ],
          ),
        ),
      ),
    );
  }
}
