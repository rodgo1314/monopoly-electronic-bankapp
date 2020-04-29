import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tronicbanking/services/database.dart';
import 'package:tronicbanking/shared/constants.dart';
import 'package:tronicbanking/Models/player.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:keyboard_utils/widgets.dart';


class PayingForm extends StatefulWidget {
  final Player player;


  PayingForm({this.player});

  @override
  _PayingFormState createState() => _PayingFormState();
}

class _PayingFormState extends State<PayingForm> {
  final _formKey = GlobalKey<FormState>();
  KeyboardUtils _keyboardUtils = KeyboardUtils();

  String paymentAmount;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text("Enter Payment Amount",style: TextStyle(fontSize: 20.0),),
          SizedBox(height: 25.0,),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText:"\$0.00") ,
            validator: (val)=> val.isEmpty ?'Please enter amount': null,
            onChanged: (val)=> setState(()=> paymentAmount = val),
            keyboardType: TextInputType.number,
          ),
          KeyboardAware(
            builder: (context, keyboardConfig) {
              return Text('is keyboard open: ${keyboardConfig.isKeyboardOpen}\n'
                  'Height: ${keyboardConfig.keyboardHeight}');
            },
          ),
          SizedBox(height: 15.0),
          CupertinoButton(
            child: Text('Submit',style: TextStyle(color: Colors.blue,fontSize: 20.0)),
            onPressed: () async{
              if (_formKey.currentState.validate()){
                int newAmount = widget.player.bankBalance + int.parse(paymentAmount);

                await DatabaseService(uid: widget.player.userID).changeUserBank(
                    newAmount ?? widget.player.bankBalance
                );
                Navigator.pop(context);
              }
            },
          )

        ],
      ),
    );
  }
}
