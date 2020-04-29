import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tronicbanking/services/auth.dart';
import 'package:tronicbanking/shared/constants.dart';
import 'package:tronicbanking/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:tronicbanking/Models/user.dart';
import 'package:tronicbanking/services/database.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  Future<User> _registerWithEmailAndPassword(BuildContext context, String email, String password) async{
    try{
      final auth = Provider.of<AuthService>(context,listen: false);

      User user = await auth.registerWithEmailAndPassword(email, password);
      await DatabaseService(uid: user.uid).createNewUser(user.uid, 'New Player', 37700000);
      return user;


    }catch(e){
      print(e.toString());
      return null;
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //textfield state
  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Container(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            Row(
              children: <Widget>[
                Icon(Icons.group_add,size:40.0),
                Text("Make An Account",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.black)
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(fillColor: Colors.red[50],hintText: 'Email'),
              validator: (val)=> val.isEmpty? 'Enter an Email':null,
              onChanged:(val) {
                setState(()=>email = val);
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(fillColor: Colors.red[50],hintText: 'Password'),
              validator: (val)=> val.length != 6 ? 'Enter 6 Digit Pin':null,
              obscureText: true,
              keyboardType: TextInputType.number,
              onChanged: (val){
                setState(()=>password=val);

              },
            ),
            SizedBox(height: 20.0),
            CupertinoButton(
              child: Text('Sign Up',style: TextStyle(color: Colors.blue,fontSize: 20.0)),
              onPressed: () async{
                if (_formKey.currentState.validate()){
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _registerWithEmailAndPassword(context, email, password);

                  if (result==null){
                    setState(() {
                      error = 'Please use a valid email';
                      loading = false;
                    });
                    return showDialog(context: context,child: CupertinoAlertDialog(
                      title: Text(error),
                      actions: <Widget>[CupertinoDialogAction(
                        child: Text('Close'),
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.of(context,rootNavigator: true).pop('Close');
                        },
                      )],

                    ));


                  }
                }

              },
            )

          ],
        ),
      ),
    );
  }
}