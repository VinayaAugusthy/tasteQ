import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tasteq/screens/login.dart';

import '../../model/authentication/authentication.dart';
import '../../widgets/call_snackbar.dart';

ValueNotifier<List<Authentication>> getUserNotifier = ValueNotifier([]);

void signUp(
    String email, String password, confirmPassword, BuildContext ctx) async {
  final userBox = await Hive.openBox<Authentication>('authentication');

  final emails = userBox.values.toList();

  final exisistingUser = emails.where((user) => user.email == email).isNotEmpty;

  if (exisistingUser) {
    // callSnackBar(msg: 'User already exist', ctx: ctx);
  } else {
    successSignup(ctx, email, password);
  }
}

bool login(String email, String password, BuildContext ctx) {
  final userBox = Hive.box<Authentication>('authentication');

  final user = userBox.values.firstWhere(
    (user) => user.email == email && user.password == password,
    orElse: () => showSnackbar(ctx),
  );
  return true;
}

successSignup(ctx, email, password) async {
  final userBox = await Hive.openBox<Authentication>('authentication');
  callSnackBar(msg: 'User signed up succesfully', ctx: ctx);
  final newUser = Authentication(email: email, password: password);
  await userBox.add(newUser);
  Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false);
}

showSnackbar(ctx) {
  callSnackBar(msg: 'username and password does not match', ctx: ctx);
}

Future<void> getUsers() async {
  final userBox = await Hive.box<Authentication>('authentication');
  getUserNotifier.value.clear();
  getUserNotifier.value.addAll(userBox.values);
  getUserNotifier.notifyListeners();
}
