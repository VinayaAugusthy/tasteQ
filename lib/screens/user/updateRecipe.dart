
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasteq/db/functions/db_functions.dart';
import 'package:tasteq/db/model/add_recipe.dart';
import 'package:tasteq/screens/user/viewRecipes.dart';
import 'package:tasteq/widgets/call_textformfield.dart';

bool flag = true;
class UpdateRecipe extends StatefulWidget {
  final int index;
  const UpdateRecipe({super.key,required this.index});

  @override
  State<UpdateRecipe> createState() => _UpdateRecipeState();
}

class _UpdateRecipeState extends State<UpdateRecipe> {

  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _durationController;
  late TextEditingController _mealTypeController;
  late TextEditingController _categoryController;
  late TextEditingController _ingrediantController;
  late TextEditingController _procedureController;
  late TextEditingController _videoLinkController;

  int id =0;
  String? name;
  String? duration;
  String? mealType;
  String? category;
  String? ingrediants;
  String? procedure;
  String? videoLink;
  String? imagepath;

   var meals = ['Breakfast','Lunch','Dinner'];
    var dropdownValue='Breakfast';
   late String mealsAvailable;
  var foodType = ['Japanese','Chinese','Thai','Arabian','Burma','Indian'];
   var dropdownFoodType='Indian';
  late String food;
   bool newLine = false;

  late Box<Add> addBox;
  late Add recipe;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addBox = Hive.box('addrecipe');

     _idController = TextEditingController();
    _nameController = TextEditingController();
    _durationController = TextEditingController();
    _mealTypeController = TextEditingController();
    _categoryController = TextEditingController();
    _ingrediantController = TextEditingController();
    _procedureController = TextEditingController();
    _videoLinkController = TextEditingController();

    recipe = addBox.getAt(widget.index) as Add;

    _idController.text = recipe.id.toString();
    log(_idController.text);
    _nameController.text = recipe.name.toString();
    log(_nameController.text);
    _durationController.text = recipe.duration.toString();
    log(_durationController.text);
    _categoryController.text = recipe.category.toString();
    log(_categoryController.text);
    _ingrediantController.text = recipe.ingrediants.toString();
    log(_ingrediantController.text);
    _procedureController.text = recipe.procedure.toString();
    log(_procedureController.text);
    _videoLinkController.text = recipe.videoLink.toString();
    log(_videoLinkController.text);
    
    
  }

  Future<void> updateButton(int index) async{
    final name = _nameController.text.trim();
    final duration = _durationController.text.trim();
     mealType = _mealTypeController.text.trim();
     category = _categoryController.text.trim();
    final ingrediants = _ingrediantController.text.trim();
    final procedure = _procedureController.text.trim();
    final videoLink = _videoLinkController.text.trim();

    mealType ??= 'Value';

   category ??= 'Category';


    if (name.isEmpty || duration.isEmpty || ingrediants.isEmpty || procedure.isEmpty) {
      return;
    }
    
    final recepies = Add(image: imagepath ?? recipe.image, name: name, duration: duration, mealType: mealType!, category:category! , ingrediants: ingrediants, procedure: procedure, videoLink: videoLink);
     final recipeDB = await Hive.openBox<Add>('addrecipe');
     recipeDB.putAt(index, recepies);
      getRecipes();
  }
 Future<void> takePhoto() async {
    // ignore: non_constant_identifier_names
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagepath = PickedFile.path;
      });
    }
  }
  Widget elavatedbtn() {
    return ElevatedButton.icon(
      onPressed: () {
        updateButton(widget.index);

        Navigator.of(context).pop(
            MaterialPageRoute(builder: (ctx) =>  const AdminRecipeList()));
            
      },
      icon: const Icon(Icons.update_rounded),
      label: const Text('Update'),
    );
  }

  Widget dpImage(){
    return Stack(
      children: [
          Stack(
            children: [
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imagepath == null ? 
                    FileImage(File(recipe.image))
                    :FileImage(File(imagepath ?? recipe.image))
                  )
                ),
              ),
            ],
          ),
          Positioned(
            top: 80,
            left: 70,
            right: 70,
            bottom: 0,
            child: InkWell(
              child: const Icon( Icons.add_a_photo_sharp,
              size: 30,
              ),
              onTap: () {
                takePhoto();
              },
            ),
          )
        ],
      );
    }

  Widget passName(){
    return callTextField(labelname: 'Recipe name', inputcontroller: _nameController, max: 1);
  }

  Widget passDuration(){
    return callTextField(labelname: 'Duration', inputcontroller: _durationController, max: 1);
  }
  Widget chooseMeals(){
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10))),
        value: meals[0],
        items: meals
            .map(
              (String meals) => DropdownMenuItem(
                value:meals ,
                child: Text(meals),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            dropdownValue = value!;
            mealsAvailable = value;
              _mealTypeController.text = value;
          });
        },
      ),
    );
  }
  Widget chooseCategory(){
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10))),
        value: foodType[0],
        items: foodType
            .map(
              (String foodType) => DropdownMenuItem(
                value:foodType ,
                child: Text(foodType),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            dropdownValue = value!;
            food = value;
              _categoryController.text = value;
          });
        },
      ),
    );
  }

  // Widget chooseCategory(){
   
  //  return callTextField(labelname: 'Category', inputcontroller: _categoryController, max: 1);
  // }
  

Widget listIngrediants(){
  return callTextField(labelname: 'Ingerediants', inputcontroller: _ingrediantController, max: 20);
}
  Widget cookingProcedure(){
      return callTextField(labelname: 'Procedure', inputcontroller: _procedureController, max: 50);
  }

Widget videolink(){
  return callTextField(labelname: 'Video Link', inputcontroller: _videoLinkController, max: 1);
}
  Widget szdBox = const SizedBox(height: 30);

  @override
  Widget build(BuildContext context) {
    // final recipes = addBox.getAt(widget.index) as Add;
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(children:<Widget> [
              dpImage(),
              szdBox,
              // passName(),
              //  textFieldName(myController: _nameController, hintName: recipes.name),
            passName(),
              szdBox,
             passDuration(),
              szdBox,
              chooseMeals(),
              szdBox,
              chooseCategory(),
              szdBox,
              listIngrediants(),
              szdBox,
              cookingProcedure(),
            szdBox,
            videolink(),
            szdBox,
            elavatedbtn(),
            ],
            )
          ],
        ),
      ),
    );
  }
}