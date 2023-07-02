
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasteq/db/functions/recent_function.dart';
import 'package:tasteq/screens/user/comment_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../db/model/add_recipe.dart';

class ViewRecipes extends StatefulWidget {
   ViewRecipes({Key? key,required this.passValue,required this.passId}):super(key: key);

Add passValue;
final int passId;

  @override
  State<ViewRecipes> createState() => _ViewRecipesState();
}


class _ViewRecipesState extends State<ViewRecipes> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addToRecent(widget.passValue);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 240),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => CommentScreen(passValue: widget.passValue)));
                  }, 
                  icon: const Icon(
                    Icons.chat_bubble_outline_outlined,
                    color: Colors.red,
                    ),
                  ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )
                ),
                width: double.maxFinite,
                child:  Center(
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.passValue.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ) ,
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: coverImage(),
            ),
          ),
            SliverToBoxAdapter(
            child:Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ) ,
                  child:  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                                const Icon(Icons.timer),
                                Text(' : ${widget.passValue.duration}')
                            ],
                          ),
                          Text(widget.passValue.mealType),
                          Text(widget.passValue.category),
                        ],
                      ),
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                        ),
                        ),
                        szdBox(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                        child: Row(
                          children: [
                            Text(
                              widget.passValue.ingrediants,style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      line(),
                      const Text(
                        'Cooking Procedure',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                        ),
                        ),
                        szdBox(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 10, 80),
                        child: Text(
                          widget.passValue.procedure
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ),
        ],
      ),
      bottomSheet: BottomSheet(
        onClosing: (){}, 
        builder:  (context) {
          return Container(
            height: 70,
            padding: const EdgeInsets.only(
              right: 30,
              left: 30,
              bottom: 10
            ),
            child: ElevatedButton(
              onPressed: (){
              redirect(widget.passValue.videoLink);
              },
             child: Padding(
               padding: const EdgeInsets.only(
                left: 70,
               ),
               child: Row(
                 children: const [
                  Icon(Icons.play_circle),
                   Text(
                    'Play Video',
                    style: TextStyle(
                      fontSize: 25
                    ),
                   ),
                 ],
               ),
             ),
            ),
          );
        }
      ),
    );
  }

  Widget coverImage(){
    return Image(image: FileImage(File(widget.passValue.image)),
     width: double.maxFinite,
    fit: BoxFit.cover,
    );
  }

  szdBox(){
    return const SizedBox(
      height: 20,
    );
  }

  line(){
    return const Divider(
      color: Colors.black,
      
    );
  }

   Future<void> redirect(url) async{
    final Uri _url= Uri.parse(url);
    if(!await launchUrl(_url)){
      throw Exception('failed');
    }
   }
}