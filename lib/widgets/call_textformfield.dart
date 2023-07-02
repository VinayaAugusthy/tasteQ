import 'package:flutter/material.dart';

callTextField({ required String labelname,required TextEditingController inputcontroller,required int max}){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: TextFormField(
      maxLines: max,
      controller: inputcontroller,
      decoration: InputDecoration(
        labelText: labelname,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}