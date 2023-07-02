
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasteq/db/model/user.dart';
import 'package:tasteq/main.dart';
import 'package:tasteq/screens/login.dart';
import 'package:tasteq/screens/user/userhome.dart';
import 'package:tasteq/widgets/call_snackbar.dart';
import '../model/add_recipe.dart';

ValueNotifier<List<Add>>getRecipeNotifier = ValueNotifier([]);
ValueNotifier<List<User>>getUserNotifier = ValueNotifier([]);

void signUp(String email,String password, confirmPassword,BuildContext ctx) async{
  final userBox = await Hive.openBox<User>('users');

  final emails = userBox.values.toList();

  final exisistingUser = emails.where((user) => user.email == email).isNotEmpty;

  if (exisistingUser) {
    callSnackBar(msg: 'User already exist', ctx: ctx);
   
  } else {
    successSignup(ctx, email, password);
  }
}


bool login(String email, String password ,BuildContext ctx) {
  final userBox = Hive.box<User>('users'); 
 
  final user = userBox.values.firstWhere(
    (user) => user.email == email && user.password == password,
    orElse: () => showSnackbar(ctx),
  );
  return true;
}
successSignup(ctx,email,password) async{
  final userBox = await Hive.openBox<User>('users');
  callSnackBar(msg: 'User signed up succesfully', ctx:ctx );
     final newUser = User(email: email, password: password);
     await userBox.add(newUser);
     Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);
}

showSnackbar(ctx) {
   callSnackBar(msg: 'username and password does not match', ctx: ctx);
}

Future<void> getUsers() async{
  final userBox = await Hive.box<User>('users'); 
  final allUsers = userBox.values.toList();
   getUserNotifier.value.clear();
   getUserNotifier.value.addAll(userBox.values);
  getUserNotifier.notifyListeners();
}

Future<void> upload(Add value) async{
  final recipebox = await Hive.openBox<Add>('addRecipe');

  await recipebox.add(value);

   getRecipes();
}

Future<void> getRecipes() async{
  final recipeDB = await Hive.openBox<Add>('addRecipe');

  allRecipes = recipeDB.values.toList();
  getRecipeNotifier.value.clear();
  getRecipeNotifier.value.addAll(recipeDB.values);
  getRecipeNotifier.notifyListeners();

}

Future<void> deleteRecipe(int id) async{
   final recipeDB = await Hive.openBox<Add>('addrecipe');
   await recipeDB.deleteAt(id);
  getRecipes();
}

signout(BuildContext ctx) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
}
