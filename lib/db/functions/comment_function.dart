

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasteq/db/model/comment.dart';


ValueNotifier<List<Comments>> commentNotifier = ValueNotifier([]);

Future getComments() async{
  final commentDB = await Hive.openBox<Comments>('comments');
  final allcomments = commentDB.values.toList();
  commentNotifier.value.clear();
  commentNotifier.value.addAll(allcomments);
  commentNotifier.notifyListeners();
}


  Future<void> createComment(Comments newComment) async{
    // final users = getUsers();
   final commentDB = await Hive.openBox<Comments>('comments');
    await commentDB.add(newComment);
    getComments();
    print(newComment);  
  }