import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasteq/db/functions/db_functions.dart';
import 'package:tasteq/screens/user/recent.dart';

import '../model/add_recipe.dart';

Future<void> addToRecent(Add recipe) async{
  print('object');
  print(recipe.name);
  final recentBox = await Hive.openBox<Add>('recent');
  Add recipelist = Add(image: recipe.image, name: recipe.name, duration: recipe.duration, mealType: recipe.mealType, category: recipe.category, ingrediants: recipe.ingrediants, procedure: recipe.procedure, videoLink: recipe.videoLink);
  
  final list = recentBox.values.toList();
  int listIndex =0;

  for (var element in recentBox.values) {
    if (recipelist.name == element.name) {
      recentBox.deleteAt(listIndex);
      recentBox.add(recipe);
      break;
    }
    listIndex++;

  }
  recentBox.add(recipe);
  getRecent();
}

Future<void> getRecent() async{
  final recentBox = await Hive.openBox<Add>('recent');
  final list = recentBox.values.toList();
  recentList = list.reversed.toList();
  // getRecipeNotifier.value.addAll(list);
  // getRecipeNotifier.notifyListeners();
}