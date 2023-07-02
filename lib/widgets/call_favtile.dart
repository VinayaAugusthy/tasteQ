import 'dart:io';


import 'package:flutter/material.dart';
import 'package:tasteq/db/functions/favourite_function.dart';
import 'package:tasteq/db/model/add_recipe.dart';
import 'package:tasteq/screens/user/view_recipes.dart';

Widget callTile(Add recipe,BuildContext context,int index){
  return ListTile(
    leading: CircleAvatar(
      radius: 25,
      backgroundImage: FileImage(File(recipe.image)),
    ),
    title: Text(recipe.name),
    subtitle: Text(recipe.category),
    trailing: IconButton(
      onPressed: (){
        delFavourite(recipe.name);
        // getFavourite();
      }, 
      icon: const Icon(Icons.remove_circle_outline_rounded),
      color: Colors.red,
      ),
      onTap:(){
         Navigator.push(context,
       MaterialPageRoute(
        builder: (context) => ViewRecipes(passValue: recipe, passId: index)));
        }
  );
}