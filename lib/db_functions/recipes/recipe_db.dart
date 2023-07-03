// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tasteq/model/recipe/recipe.dart';

ValueNotifier<List<Recipe>> getRecipeNotifier = ValueNotifier([]);

upload(Recipe value) async {
  final recipebox = await Hive.openBox<Recipe>('recipes');

  await recipebox.add(value);

  getRecipes();
}

getRecipes() async {
  final recipeDB = await Hive.openBox<Recipe>('recipes');
  getRecipeNotifier.value.clear();
  getRecipeNotifier.value.addAll(recipeDB.values);
  getRecipeNotifier.notifyListeners();
}

Future<void> deleteRecipe(int id) async {
  final recipeDB = await Hive.openBox<Recipe>('recipes');
  await recipeDB.deleteAt(id);
  getRecipes();
}
