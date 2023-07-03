import 'package:hive/hive.dart';
part 'authentication.g.dart';

@HiveType(typeId: 0)
class Authentication {
  @HiveField(0)
  String email;
  @HiveField(1)
  String password;
  Authentication({required this.email, required this.password});
}
