import 'package:hive_flutter/adapters.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User {

  @HiveField(0)
  String email;

  @HiveField(1)
  String password;

  User({required this.email,required this.password});
}