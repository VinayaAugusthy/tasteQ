import 'package:flutter/material.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
    padding: EdgeInsets.only(
      right: MediaQuery.of(context).devicePixelRatio,
      left: MediaQuery.of(context).devicePixelRatio,
      top: MediaQuery.of(context).devicePixelRatio,
      bottom: MediaQuery.of(context).devicePixelRatio,
    ),
    child: Column(
      children: const [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Text(
            'Welcome to TasteQ! Our mission is to help you discover new and delicious recipes to try in your own kitchen.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Text('\n'),
        Padding(
          padding: EdgeInsets.only(
             left: 10,
             right: 10,
          ),
          child: Text(
            'Our app features a wide variety of recipes, from quick and easy weeknight dinners to more complex dishes for special occasions. We strive to include recipes that are not only tasty, but also healthy and nutritious.',
              style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            ),
        ),
        Text('\n'),
        Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Text(
            'But we don\'t just want to provide you with recipes - we want you to share your own! Our app allows you to easily upload your favorite recipes to share with our community. Simply navigate to the Upload section of the app, enter your recipe details and a photo, and submit it for review. Once approved, your recipe will be added to our collection for others to discover and enjoy.',
              style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            ),
        ),
        Text('\n'),
        Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Text(
            'Thank you for choosing TasteQ. We are always working to improve and enhance the app, so if you have any feedback or suggestions, please don\'t hesitate to let us know. Happy cooking!',
              style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            ),
        ),
        ],
       ),
     ),
    ),
  );
 }
  style(){
  return TextStyle(
    fontWeight: FontWeight.normal,
  );
 }
}