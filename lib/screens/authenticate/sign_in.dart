import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tronicbanking/services/auth.dart';
import 'package:tronicbanking/shared/constants.dart';
import 'package:tronicbanking/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:tronicbanking/Models/user.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  Future<User> _signInWithEmailAndPassword(BuildContext context, String email, String password) async{
    try{
      final auth = Provider.of<AuthService>(context,listen: false);
      return await auth.signInWithEmailAndPassword(email, password);

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
                Icon(Icons.account_balance,size: 40.0,),
                Text("Monopoly Bank",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.black)
                ),
                Icon(Icons.account_balance,size: 40.0)
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
              child: Text('Sign In',style: TextStyle(color: Colors.blue,fontSize: 20.0)),
              onPressed: () async{
                if (_formKey.currentState.validate()){
                  setState(() => loading = true);
                  dynamic result = await _signInWithEmailAndPassword(context,email, password);
                  if (result==null){
                    setState(() {
                      error = 'Could not sign in with those credentials';
                      loading = false;
                    }
                    );
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
