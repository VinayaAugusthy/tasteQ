
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasteq/db/functions/comment_function.dart';
import 'package:tasteq/db/model/comment.dart';
import 'package:tasteq/screens/user/userhome.dart';
import '../../db/model/add_recipe.dart';


class CommentScreen extends StatefulWidget {
   CommentScreen({super.key,required this.passValue});

  Add passValue;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  late Box<Comments> commentBox;
  late List<Comments> recipeComment =[];

  final commentController = TextEditingController();
  
  
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     getComments();
     commentBox = Hive.box<Comments>('comments');
     
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: commentNotifier,
        builder: (BuildContext context, List<Comments> list,Widget? child){
           recipeComment = list.where((recipes) => recipes.recipeName == widget.passValue.name).toList();
        return ListView.builder(
          itemCount: recipeComment.length,
          itemBuilder: (context,index){
             final data = recipeComment[index];
            return Card(
              margin: const EdgeInsets.fromLTRB(20,10,20,10),
              elevation: 3,
              color: Colors.red[50],
              child:  ListTile(
                title: Text(
                  data.userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                  ),
                 subtitle: Text(
                  data.comment,
                  style: const TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            );
          },
        );
        },
      ),
       floatingActionButton : FloatingActionButton(
        onPressed: (){
          showForm(context,null);
        },
        child: const Icon(Icons.edit),
        ),
      );  
    }

  void showForm(BuildContext ctx,int? itemKey) async{
    showModalBottomSheet(
      context: ctx, 
      builder: (_){
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  hintText: 'Add a comment'
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async{
                  postComment();
                   commentController.text = '';
                  Navigator.of(context).pop();
                }, 
                child: const Text('POST'),
                ),
                const SizedBox(
                  height: 15,
                )
            ],
          ),
        );
      },
    );
  }

 void postComment(){
  final username = usname.toString();
  final comment = commentController.value.text;
  final recipeName = widget.passValue.name;

  final listComments = Comments(userName: username, comment: comment, recipeName: recipeName);
  createComment(listComments);
 }
}