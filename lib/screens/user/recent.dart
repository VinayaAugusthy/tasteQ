import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasteq/db/functions/recent_function.dart';
import 'package:tasteq/screens/user/view_recipes.dart';

import '../../db/model/add_recipe.dart';

List<Add> recentList =[];

class Recent extends StatefulWidget {
  const Recent({super.key});
  

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Hive.box<Add>('recent');
    getRecent();
  }
  @override
  Widget build(BuildContext context) {
    List<Add> recent = recentList.toSet().toList();
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Recent Uploads'),
        centerTitle: true,
      ),
      body:SafeArea(
        child: ListView.builder(
          itemBuilder: (context,index){
            final data = recent[index];
            return ListTile(
              onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>ViewRecipes(passValue: data, passId:index )));
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: FileImage(File(data.image)),
              ),
              title: Text(
                data.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            );
          },
          itemCount: recent.length,
        )
      )
    );     
  }
}