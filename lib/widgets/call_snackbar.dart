import 'package:flutter/material.dart';

void callSnackBar({required var msg,required BuildContext ctx}){
  // var msg = '';
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10) ),
      content: Text(msg)
      )
  );
}