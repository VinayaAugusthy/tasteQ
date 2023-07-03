import 'package:flutter/material.dart';

import '../screens/favourites.dart';
import '../screens/home.dart';
import '../screens/upload_recipe.dart';

final navItems = [
  const HomeScreen(),
  const UploadRecipe(),
  const FavouriteScreen()
];
final categoryItems = [
  'Breakfast',
  'Lunch',
  'Dinner',
  'Indian',
  'Chinese',
  'Italian'
];
const heightBox10 = SizedBox(height: 10);
const heightBox20 = SizedBox(height: 20);
const heightBox30 = SizedBox(height: 30);
int index = 0;
