
import 'package:flutter/material.dart';

const textinputDecoration = InputDecoration(
    contentPadding: EdgeInsets.all(4.0),
    fillColor: Colors.white,
    filled: true,
    hintStyle: TextStyle(
      color: Colors.black,
    ),
    prefixIcon: Icon(
      Icons.attach_money,
      color: Colors.blue,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
    ));
