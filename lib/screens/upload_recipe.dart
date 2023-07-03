import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/constants.dart';
import '../model/recipe/recipe.dart';
import '../widgets/call_snackbar.dart';
import '../widgets/call_textformfield.dart';

class UploadRecipe extends StatefulWidget {
  const UploadRecipe({super.key});

  @override
  State<UploadRecipe> createState() => _UploadRecipeState();
}

class _UploadRecipeState extends State<UploadRecipe> {
  var dropdownValue = 'Breakfast';
  late String categoryValue;
  String? imagepath;
  final _recipeNameController = TextEditingController();
  final _durationController = TextEditingController();
  final _categoryController = TextEditingController();
  final _ingrediantController = TextEditingController();
  final _cookController = TextEditingController();
  final _videoLinkController = TextEditingController();
  bool newLine = false;

  late Box<Recipe> addBox;

  @override
  void initState() {
    // TODO: implement initState

    _ingrediantController.addListener(() {
      // print(_ingrediantController.text);
      String ingrediant = _ingrediantController.text;
      if (ingrediant.isEmpty &&
          ingrediant.substring(ingrediant.length - 1) == '\u2022') {
        // print('newline');
        setState(() {
          newLine = true;
        });
      } else {
        setState(() {
          newLine = false;
        });
      }
    });
    super.initState();
    // createBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add recipes'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          heightBox30,
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imagepath == null
                      ? const AssetImage('assets/images/download.png')
                          as ImageProvider
                      : FileImage(File(imagepath!)),
                )),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: 80,
                child: InkWell(
                  child: const Icon(
                    Icons.add_a_photo_sharp,
                    size: 30,
                  ),
                  onTap: () {
                    addPhoto(context);
                  },
                ),
              )
            ],
          ),
          heightBox20,
          callTextField(
            labelname: 'Name of recipe',
            inputcontroller: _recipeNameController,
            max: 1,
          ),
          callTextField(
            labelname: 'Cooking Duration',
            inputcontroller: _durationController,
            max: 1,
          ),
          heightBox30,
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: SizedBox(
              height: 55,
              width: 340,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: 'Breakfast',
                items: categoryItems
                    .map(
                      (String categoryType) => DropdownMenuItem(
                        value: categoryType,
                        child: Text(categoryType),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value!;
                    categoryValue = value;
                    _categoryController.text = value;
                  });
                },
              ),
            ),
          ),
          heightBox30,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              maxLines: 20,
              autovalidateMode: AutovalidateMode.always,
              controller: _ingrediantController,
              onChanged: (value) {
                Future.delayed(const Duration(milliseconds: 1000), () {
                  if (newLine) {
                    return;
                  }
                  String ingrediants = _ingrediantController.text;
                  if (ingrediants.isEmpty) {
                    _ingrediantController.text =
                        '${_ingrediantController.text}\u2022';
                    _ingrediantController.selection =
                        TextSelection.fromPosition(
                      TextPosition(offset: _ingrediantController.text.length),
                    );
                  }
                  if (ingrediants.isNotEmpty &&
                      ingrediants.substring(ingrediants.length - 1) == '\n') {
                    _ingrediantController.text =
                        '${_ingrediantController.text}\u2022';
                    _ingrediantController.selection =
                        TextSelection.fromPosition(
                      TextPosition(offset: _ingrediantController.text.length),
                    );
                  }
                });
              },
              decoration: InputDecoration(
                labelText: 'Ingrediants',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          callTextField(
            labelname: 'How to cook',
            inputcontroller: _cookController,
            max: 50,
          ),
          callTextField(
            labelname: 'Video link',
            inputcontroller: _videoLinkController,
            max: 1,
          ),
          ElevatedButton(
            onPressed: () {
              if (_recipeNameController.text.isNotEmpty &&
                  _durationController.text.isNotEmpty &&
                  _categoryController.text.isNotEmpty &&
                  _ingrediantController.text.isNotEmpty &&
                  _cookController.text.isNotEmpty) {
                addOnButtonClicked();
                successUpload();
              } else {
                showSnackBar();
              }
            },
            child: const Text('UPLOAD'),
          )
        ],
      ),
    );
  }

  addPhoto(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagepath = pickedFile.path;
      });
    }
  }

  void addOnButtonClicked() {
    final name = _recipeNameController.text;
    final duration = _durationController.text;
    final category = _categoryController.text;
    final ingrediants = _ingrediantController.text;
    final procedure = _cookController.text;
    final videolink = _videoLinkController.text;

    final addedList = Recipe(
        image: imagepath!,
        name: name,
        duration: duration,
        category: category,
        ingrediants: ingrediants,
        procedure: procedure,
        videoLink: videolink);
    // upload(addedList, context);
    print('kitty');
  }

  successUpload() {
    callSnackBar(msg: 'Recipe uploaded successfully', ctx: context);
  }

  showSnackBar() {
    if (imagepath == null &&
        _recipeNameController.text.isEmpty &&
        _durationController.text.isEmpty &&
        _categoryController.text.isEmpty &&
        _ingrediantController.text.isEmpty &&
        _cookController.text.isEmpty) {
      callSnackBar(msg: 'Please fill all the fields', ctx: context);
    } else if (imagepath == null) {
      callSnackBar(msg: 'Please fill image', ctx: context);
    } else if (_recipeNameController.text.isEmpty) {
      callSnackBar(msg: 'Please fill recipe name', ctx: context);
    } else if (_durationController.text.isEmpty) {
      callSnackBar(msg: 'Please fill duration field', ctx: context);
    } else if (_categoryController.text.isEmpty) {
      callSnackBar(msg: 'Please select category type', ctx: context);
    } else if (_ingrediantController.text.isEmpty) {
      callSnackBar(msg: 'Please fill ingrediants field', ctx: context);
    } else if (_cookController.text.isEmpty) {
      callSnackBar(msg: 'Please fill how to cook field', ctx: context);
    } else if (_videoLinkController.text.isEmpty) {
      callSnackBar(msg: 'Please fill video link field', ctx: context);
    }
  }
}
