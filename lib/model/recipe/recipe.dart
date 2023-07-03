import 'package:hive/hive.dart';
part 'recipe.g.dart';

@HiveType(typeId: 1)
class Recipe {
  @HiveField(0)
  String image;
  @HiveField(1)
  String name;
  @HiveField(2)
  String duration;
  @HiveField(3)
  String category;
  @HiveField(4)
  String ingrediants;
  @HiveField(5)
  String procedure;
  @HiveField(6)
  String videoLink;
  @HiveField(7)
  int? id;
  Recipe(
      {required this.image,
      required this.name,
      required this.duration,
      required this.category,
      required this.ingrediants,
      required this.procedure,
      required this.videoLink,
      this.id});
}
