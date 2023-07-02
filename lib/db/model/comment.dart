import 'package:hive_flutter/hive_flutter.dart';
part 'comment.g.dart';

@HiveType(typeId: 2)
class Comments {
  
  @HiveField(0)
  String userName;

  @HiveField(1)
  String comment;

  @HiveField(2)
  String recipeName;

  Comments({required this.userName,required this.comment,required this.recipeName});
  
}