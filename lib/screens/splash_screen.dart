import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasteq/main.dart';
import 'package:tasteq/screens/login.dart';
import 'package:tasteq/screens/user/userhome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo3.png'),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future gotoLogin() async {
    await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }

  Future<void> checkUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userLogged = prefs.getBool(SAVE_KEY_NAME);

    if (userLogged == false || userLogged == null) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => UserHome(),
      ));
    }
  }
}
