import 'package:flutter/material.dart';


class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Terms and conditions'),
        centerTitle: true,
      ),
        body: ListView(
          children: 
              [
                SafeArea(
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
              right: 10
            ),
            child: Text(
                '1. User-generated content: By submitting a recipe, you acknowledge that you are the creator of the recipe and have the right to submit it. You also grant the app owner a non-exclusive, royalty-free, perpetual, worldwide license to use, display, modify, and distribute your recipe in any way deemed appropriate.',
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
              right: 10
            ),
            child: Text(
                '2.  Accuracy of information: The app owner makes no warranties or representations regarding the accuracy, completeness, or reliability of the information provided in the recipes. Users are solely responsible for verifying the accuracy of the information provided in the recipes and for any consequences that may arise from the use of such information.',
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
              right: 10
            ),
            child: Text(
                '3.  Prohibited content: The app owner reserves the right to reject or remove any recipe that contains prohibited content, such as content that is unlawful, harmful, threatening, abusive, harassing, defamatory, vulgar, obscene, or invasive of another\'s privacy.',
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
              right: 10
            ),
            child: Text(
                '4.  Modification of terms: The app owner reserves the right to modify these terms and conditions at any time without prior notice. Users are encouraged to review the terms and conditions periodically to stay informed of any changes.',
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
              right: 10
             ),
             child: Text(
                '5.  Governing law: These terms and conditions shall be governed by and construed in accordance with the laws of the jurisdiction in which the app owner is located.',
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                ),
           ),
              SizedBox(
                height: 40,
              )
              ],
              ),
            ),
          ),
        ],
      ),
    );
  } 
}