import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasteq/model/recipe/recipe.dart';
import '../db_functions/recipes/recipe_db.dart';

class ManageRecipesScreen extends StatefulWidget {
  const ManageRecipesScreen({super.key});

  @override
  State<ManageRecipesScreen> createState() => _ManageRecipesScreenState();
}

class _ManageRecipesScreenState extends State<ManageRecipesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hive.openBox<Recipe>('recipes');
    getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: getRecipeNotifier,
          builder: (BuildContext ctx, List<Recipe> recipeList, Widget? child) {
            return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = recipeList[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    // backgroundColor: Colors.green,
                    backgroundImage: FileImage(File(data.image)),
                  ),
                  title: Text(data.name),
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => UpdateRecipe(index: index),
                            //   ),
                            // );
                          },
                          icon: const Icon(Icons.edit),
                          color: Colors.blue),
                      IconButton(
                        onPressed: () {
                          deleteAlert(context, index);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (ctx) => ViewRecipes(
                    //       passId: index,
                    //       passValue: data,
                    //     ),
                    //   ),
                    // );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: recipeList.length,
            );
          },
        ),
      ),
    );
  }

  deleteAlert(BuildContext context, key) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text('Delete data Permanently?'),
        actions: [
          TextButton(
              onPressed: () {
                deleteRecipe(key);
                Navigator.of(context).pop(ctx);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(ctx);
              },
              child: const Text('Cancel'))
        ],
      ),
    );
  }
}
