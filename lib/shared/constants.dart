import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent,width: 2.0)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black,width: 3.0)
    )
);