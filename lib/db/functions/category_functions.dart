import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasteq/db/model/add_recipe.dart';

ValueNotifier<List<Add>> categoryNotifier = ValueNotifier([]);

// ValueNotifier<List<Add>> mealNotifier = ValueNotifier([]);

Future<void> categorySorting(String selectedCategory) async{
  final recipeDB = await Hive.openBox<Add>('addRecipe');

  final recipe = recipeDB.values.toList();
  categoryNotifier.value.clear();
  for (var pickRecipes in recipe) {
    if (pickRecipes.category == selectedCategory) {
      categoryNotifier.value.add(pickRecipes);
      categoryNotifier.notifyListeners();
    }
  }
}