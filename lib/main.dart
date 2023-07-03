import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'model/authentication/authentication.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  Hive.registerAdapter(AuthenticationAdapter());
  await Hive.openBox<Authentication>('authentication');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TasteQ',
      theme: ThemeData(primarySwatch: Colors.red),
      // home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
