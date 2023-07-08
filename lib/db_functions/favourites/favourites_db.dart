// ignore_for_file: invalid_use_of_protected_member
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasteq/model/recipe/recipe.dart';
import '../recipes/recipe_db.dart';

List<Recipe> favList = [];
makeFavourite(String name, Recipe recipe) async {
  final favouriteDB = await Hive.box<Recipe>('favourites');
  favouriteDB.put(name, recipe);
  getFavourite();
}

getFavourite() async {
  final favouriteDB = await Hive.openBox<Recipe>('favourites');
  favList.addAll(favouriteDB.values);
  getRecipeNotifier.value.clear();
  getRecipeNotifier.value.addAll(favouriteDB.values);
  // ignore: invalid_use_of_visible_for_testing_member
  getRecipeNotifier.notifyListeners();
}

delFavourite(String name) async {
  final favouriteDB = await Hive.openBox<Recipe>('favourites');
  await favouriteDB.delete(name);
  // ignore: invalid_use_of_visible_for_testing_member
  getRecipeNotifier.notifyListeners();
  getFavourite();
  print(favouriteDB.values);
}
