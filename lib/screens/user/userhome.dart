import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tasteq/db/functions/db_functions.dart';
import 'package:tasteq/db/functions/recent_function.dart';
import 'package:tasteq/db/model/add_recipe.dart';
import 'package:tasteq/screens/user/addRecipe.dart';
import 'package:tasteq/screens/user/recent.dart';
import 'package:tasteq/screens/user/viewRecipes.dart';
import 'package:tasteq/screens/user/favourite_list.dart';
import 'package:tasteq/screens/user/read_about.dart';
import 'package:tasteq/screens/user/terms.dart';

import '../recipes_list.dart';

String? usname;

List<Add> allRecipes = [];
int tabIndex = 0;
int gridIndex = 0;
late Box<Add> recipeList;
List mealType = ['Breakfast', 'Lunch', 'Dinner'];
List categoryType = [
  'Japanese',
  'Chinese',
  'Thai',
  'Arabian',
  'Burma',
  'Indian'
];
List bottomNavigation = [UserHome(), const AddRecipe(), const FavouriteList()];
int bottomIndex = 0;

// ignore: must_be_immutable
class UserHome extends StatefulWidget {
  UserHome({super.key, this.username});
  String? username;

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  void _onItemTapped(int index) {
    setState(() {
      bottomIndex = index;
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => bottomNavigation[index]));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipes();
    Hive.openBox<Add>('recent');
    getRecent();
  }

  @override
  Widget build(BuildContext context) {
    usname = widget.username;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              signout(context);
              // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>const LoginScreen()));
            },
            icon: const Icon(Icons.logout),
          )
        ],
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
          currentIndex: bottomIndex,
          onTap: _onItemTapped),
      drawer: SidebarX(
        headerBuilder: (context, extended) {
          return SizedBox(
            child: Column(
              children: [
                Image.asset('assets/images/logo3.png'),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewInsets.top),
                  child: Text(
                    '$usname',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Recent()));
            },
          ),
          SidebarXItem(
            icon: Icons.settings_outlined,
            label: '   Manage your recipes',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminRecipeList()));
            },
          ),
          SidebarXItem(
            icon: Icons.info,
            label: '   About',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
          ),
          SidebarXItem(
            icon: Icons.title,
            label: '   Terms and Policy',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TermsScreen()));
            },
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                    child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 20, top: 10, left: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  tabIndex = index;
                                  print('tabIndex : $tabIndex');
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: tabIndex == index
                                        ? Colors.red
                                        : const Color.fromARGB(
                                            201, 245, 222, 222),
                                    boxShadow: [
                                      BoxShadow(
                                        color: tabIndex == index
                                            ? Colors.red
                                            : Colors.transparent,
                                        offset: tabIndex == index
                                            ? const Offset(1, 1)
                                            : const Offset(0, 0),
                                        blurRadius: tabIndex == index ? 10 : 0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 10),
                                  child: Text(
                                    mealType[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: tabIndex == index
                                          ? Colors.white
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 185, 185, 255),
                            offset: Offset(1, 1),
                            blurRadius: 7,
                          )
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          gridIndex = index;
                          print('gridIndex: $gridIndex');
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => RecipesList(
                                  id: index,
                                  selectedCategory: categoryType[index],
                                )));
                      },
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Text(
                            categoryType[index],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  );
                },
                childCount: 6,
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
}
