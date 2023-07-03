import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import '../constants/constants.dart';
import '../db_functions/recipes/recipe_db.dart';
import '../model/recipe/recipe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> recipeList = []; // Replace this with your recipe list

  @override
  void initState() {
    super.initState();
    print(recipeList.length);
    getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    final tabItems = recipeList.toList();
    final categories = tabItems
        .map((recipeElement) => recipeElement.category)
        .toSet()
        .toList();

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favourites',
              ),
            ],
            showUnselectedLabels: true,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black,
            currentIndex: index,
            onTap: _onItemTapped),
        drawer: SidebarX(
          headerBuilder: (context, extended) {
            return SizedBox(
              child: Image.asset('assets/images/logo3.png'),
            );
          },
          headerDivider: const SizedBox(
            height: 10,
          ),
          extendedTheme: const SidebarXTheme(
            width: 200,
          ),
          controller: SidebarXController(selectedIndex: 0),
          items: [
            SidebarXItem(
              icon: Icons.settings_outlined,
              label: '   Recent uploads',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const Recent()),
                // );
              },
            ),
            SidebarXItem(
              icon: Icons.settings_outlined,
              label: '   Manage your recipes',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const AdminRecipeList()),
                // );
              },
            ),
            SidebarXItem(
              icon: Icons.info,
              label: '   About',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const AboutScreen()),
                // );
              },
            ),
            SidebarXItem(
              icon: Icons.title,
              label: '   Terms and Policy',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const TermsScreen()),
                // );
              },
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              heightBox10,
              TabBar(
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.redAccent,
                ),
                unselectedLabelColor: Colors.black,
                tabs: categories
                    .map(
                      (items) => Tab(
                        child: Text(items),
                      ),
                    )
                    .toList(),
              ),
              Expanded(
                child: recipeList.isNotEmpty
                    ? TabBarView(
                        children: categories
                            .map(
                              (category) =>
                                  callGrid(tabItems, category, context),
                            )
                            .toList(),
                      )
                    : const Center(
                        child: Text(
                          'Please add recipes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      // bottomIndex = index;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => navItems[index]));
    });
  }
}

Widget callGrid(List<Recipe> recipes, String category, BuildContext context) {
  final filteredRecipes =
      recipes.where((recipe) => recipe.category == category).toList();
  return SizedBox(
    height: 200,
    child: CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final dataCategory = filteredRecipes[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 185, 185, 255),
                        offset: Offset(1, 1),
                        blurRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    key: ValueKey(dataCategory.id),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                // Toggle favorite state
                                // setState(() {
                                //   dataCategory.isFavorite =
                                //       !dataCategory.isFavorite;
                                // });
                              },
                              icon: Icon(
                                // dataCategory.isFavorite
                                //     ? Icons.favorite
                                Icons.favorite_outline_outlined,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (ctx) => ViewRecipes(
                          //     passValue: dataCategory,
                          //     passId: index,
                          //   ),
                          // ));
                        },
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(dataCategory.image)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        dataCategory.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: filteredRecipes.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 270,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
          ),
        ),
      ],
    ),
  );
}
