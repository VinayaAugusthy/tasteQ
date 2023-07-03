import 'package:flutter/material.dart';
import 'package:tasteq/model/recipe/recipe.dart';
import 'package:tasteq/widgets/call_favtile.dart';

import '../db_functions/recipes/recipe_db.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipes();
    // getFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: getRecipeNotifier,
        builder: (BuildContext context, List<Recipe> favList, Widget? child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final fav = favList[index];
                return callTile(fav, context, index);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: favList.length);
        },
      ),
    );
  }
}
