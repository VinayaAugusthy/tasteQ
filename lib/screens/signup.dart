import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasteq/model/authentication/authentication.dart';
import 'package:tasteq/widgets/call_snackbar.dart';
import 'package:tasteq/widgets/call_textformfield.dart';

import '../db_functions/authentication/authentication.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  //  get username => null;

  late Box box1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hive.openBox('authentication');
    createBox();
  }

  void createBox() async {
    box1 = await Hive.openBox<Authentication>('authentication');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
              ),
            ],
          ),
          height: 450,
          width: 300,
          // color:  const Color.fromARGB(255, 238, 238, 237),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'SIGNUP',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                callTextField(
                    labelname: 'Username',
                    inputcontroller: _emailController,
                    max: 1),
                callTextField(
                    labelname: 'Password',
                    inputcontroller: _passwordController,
                    max: 1),
                callTextField(
                    labelname: 'Confirm Password',
                    inputcontroller: _confirmpasswordController,
                    max: 1),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      signUpAction();
                    },
                    child: const Text('SIGNUP'),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> signUpAction() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmpassword = _confirmpasswordController.text.trim();
    if (email.isEmpty || password.isEmpty || confirmpassword.isEmpty) {
      showSnackBar();
    } else {
      passwordMatch();
    }
  }

  showSnackBar() {
    var errMsg = "";

    if (_emailController.text.isEmpty &&
        _passwordController.text.isEmpty &&
        _passwordController.text.isEmpty) {
      errMsg = "Please Insert Valid Data In All Fields ";
    } else if (_emailController.text.isEmpty) {
      errMsg = "email  Must Be Filled";
    } else if (_passwordController.text.isEmpty) {
      errMsg = "password  Must Be Filled";
    } else if (_confirmpasswordController.text.isEmpty) {
      errMsg = "Confirm password Must Be Filled";
    }
    // else if(_passwordController.text != _confirmpasswordController.text){
    //   _errMsg = 'Password and confirm password must be same';
    // }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10.0),
        content: Text(errMsg),
      ),
    );
  }

  passwordMatch() {
    if (_passwordController.text != _confirmpasswordController.text) {
      callSnackBar(msg: 'Enter same password to continue', ctx: context);
    } else {
      signUp(_emailController.text, _passwordController.text,
          _confirmpasswordController.text, context);
    }
  }
}
