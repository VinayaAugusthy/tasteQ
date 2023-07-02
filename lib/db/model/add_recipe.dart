import 'package:hive/hive.dart';
part 'add_recipe.g.dart';


@HiveType(typeId: 1)
class Add {

  @HiveField(0)
  int? id;

  @HiveField(1)
  String image;

  @HiveField(2)
  String name;

  @HiveField(3)
  String duration;

  @HiveField(4)
  String mealType;

  @HiveField(5)
  String category;

  @HiveField(6)
  String ingrediants;

  @HiveField(7)
  String procedure;

  @HiveField(8)
  String videoLink;

  Add({required this.image,required this.name,required this.duration,required this.mealType,required this.category,required this.ingrediants,required this.procedure,required this.videoLink,this.id});
}