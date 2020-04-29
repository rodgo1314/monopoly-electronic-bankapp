import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tronicbanking/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:tronicbanking/Models/user.dart';
import 'package:tronicbanking/services/database.dart';
class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 60.0;
}

class CustomDialog extends StatefulWidget {
  final String title;
  final Icon icon;

  CustomDialog({
    @required this.title,
    this.icon,
  });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final _formKey = GlobalKey<FormState>();
  String _paymentAmount;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: EdgeInsets.only(top: Consts.avatarRadius),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: [
              BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            )]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Bank Pays You",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.0),

                SizedBox(height: 12.0),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Enter Amount") ,
                    validator: (val)=> val.isEmpty ?'Please enter amount': null,
                    onChanged: (val)=> setState(()=> _paymentAmount = val),
                    keyboardType: TextInputType.number,
                  ),

                ),
                SizedBox(height: 10.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      onPressed: () async{
                          await DatabaseService(uid: userData.uid)
                              .changeUserBank(
                              (userData.bankBalance + 2000000)  ?? userData.bankBalance
                          );
                          Navigator.pop(context);
                          print("done");
                      },
                      child: Text("Collect Go",style: TextStyle(color: Colors.blue),),
                      ),
                    CupertinoButton(
                      onPressed: () async{
                        if (_formKey.currentState.validate()){
                          await DatabaseService(uid: userData.uid)
                              .changeUserBank(
                              (userData.bankBalance + int.parse(_paymentAmount))  ?? userData.bankBalance
                          );
                          Navigator.pop(context);
                          print("done");
                        }

                      },
                      child: Text("Pay Me",style: TextStyle(color: Colors.blue),),
                    ),

                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: Consts.padding,
            right: Consts.padding,
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: Consts.avatarRadius,
              child: Icon(Icons.account_balance,size: 60,color: Colors.white,),
            ),
          ),



        ],
      ),
    );
  }
}
