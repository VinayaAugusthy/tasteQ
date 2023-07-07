import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasteq/screens/splash_screen.dart';
import 'model/authentication/authentication.dart';
import 'model/recipe/recipe.dart';

const SAVE_KEY_NAME = 'UserLoggedIn';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AuthenticationAdapter());
  Hive.registerAdapter(RecipeAdapter());
  await Hive.openBox<Authentication>('authentication');
  await Hive.openBox<Recipe>('recipes');
  // await Hive.openBox<Recipe>('favourites');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TasteQ',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
