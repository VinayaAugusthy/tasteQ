
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasteq/db/functions/db_functions.dart';
import 'package:tasteq/db/model/add_recipe.dart';

Future<void> makeFavourite(String name,Add recipe) async{
  // print('reached');
  // print(name);
  // print(recipe.ingrediants);
  final favouriteDB = await Hive.box<Add>('favourites');
  favouriteDB.put(name, recipe);
  getFavourite();
}

Future<void> getFavourite() async{
  final favouriteDB = await Hive.openBox<Add>('favourites');
  // final favRecipe = favouriteDB.values.toList();
  getRecipeNotifier.value.clear();
  getRecipeNotifier.value.addAll(favouriteDB.values);
  getRecipeNotifier.notifyListeners();
}

Future<void> delFavourite(String name) async{
  final favouriteDB = await Hive.openBox<Add>('favourites');
  await favouriteDB.delete(name);
  getRecipeNotifier.notifyListeners();
  getFavourite();
  print(favouriteDB.values);
}

