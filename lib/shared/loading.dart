import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[50],
      child: Center(
        child: CupertinoActivityIndicator(
          animating: true,
          radius: 30.0,
        ),
      ),
    );
  }
}