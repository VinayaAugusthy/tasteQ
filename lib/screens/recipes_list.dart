import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasteq/db/functions/category_functions.dart';
import 'package:tasteq/db/functions/db_functions.dart';
import 'package:tasteq/db/functions/favourite_function.dart';
import 'package:tasteq/db/model/user.dart';
import 'package:tasteq/screens/user/userhome.dart';
import 'package:tasteq/screens/user/view_recipes.dart';

import '../../db/model/add_recipe.dart';

class RecipesList extends StatefulWidget {
  RecipesList({super.key, required this.id, required this.selectedCategory});

  int id;
  String email = '';
  String selectedCategory = '';

  @override
  State<RecipesList> createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  late Box<Add> addBox;
  late Box<Add> favBox;
  late Box<User> userBox;
  late List<Add> filteredRecipes = [];
// late Add value;

  int index = 0;
  int tab = 0;
  var selectedRecipe;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    tab = tabIndex;
    getRecipes();
    getUsers();
    addBox = Hive.box<Add>('addrecipe');
    favBox = Hive.box<Add>('favourites');
    userBox = Hive.box<User>('users');

    filteredRecipes = addBox.values
        .where((recipe) =>
            recipe.category == categoryType[gridIndex] &&
            recipe.mealType == mealType[tabIndex])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recipes',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: getRecipeNotifier,
          builder: (BuildContext context, List<Add> recipeList, Widget? child) {
            categorySorting(widget.selectedCategory);
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ValueListenableBuilder(
                          valueListenable: categoryNotifier,
                          builder: (BuildContext context,
                              List<Add> categoryList, Widget? child) {
                            final datacategory = categoryList[index];
                            selectedRecipe = datacategory.name;
                            final isFavourited =
                                favBox.get(selectedRecipe) != null;
                            print('list:${filteredRecipes.length}');
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 185, 185, 255),
                                      offset: Offset(1, 1),
                                      blurRadius: 5,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                key: ValueKey(datacategory.id),
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                          onPressed: () {
                                            if (isFavourited) {
                                              delFavourite(selectedRecipe);
                                            } else {
                                              makeFavourite(
                                                  selectedRecipe, datacategory);
                                            }
                                          },
                                          icon: Icon(
                                              isFavourited
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_outline_outlined,
                                              color: Colors.red,
                                              size: 40),
                                        ),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) => ViewRecipes(
                                                  passValue: datacategory,
                                                  passId: index)));
                                    },
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image:
                                            FileImage(File(datacategory.image)),
                                        fit: BoxFit.cover,
                                      )),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    datacategory.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      childCount: filteredRecipes.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 270,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
