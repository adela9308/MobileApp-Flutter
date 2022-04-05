import 'package:captain_cook_flutter/domain/ingredient.dart';
import 'package:captain_cook_flutter/domain/recipe.dart';
import 'package:captain_cook_flutter/domain/recipe_ingredient.dart';
import 'package:captain_cook_flutter/repos/recpie_repo.dart';
import 'package:flutter/material.dart';

import 'my_recipes_screen.dart';


class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key, required this.title,required this.recipeRepo,required Function() this.notifyChange}) : super(key: key);
  final String title;
  final RecipeRepo recipeRepo;
  final Function() notifyChange;

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final denumire = TextEditingController();
  final modPreparare = TextEditingController();
  final timpPregatire = TextEditingController();
  final calorii = TextEditingController();
  final imagineURL = TextEditingController();

  bool value = false;
  final ingredients = [
    CheckBoxState(id:0, title: 'Sugar'),
    CheckBoxState(id:1, title: 'Flour'),
    CheckBoxState(id:2, title: 'Lemon'),
    CheckBoxState(id:3, title: 'Milk'),
    CheckBoxState(id:4, title: 'Salt'),
    CheckBoxState(id:5, title: 'Oil'),
  ];
  @override
  void dispose(){
    denumire.dispose();
    modPreparare.dispose();
    timpPregatire.dispose();
    calorii.dispose();
    imagineURL.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body:ListView(
      children:[Column(children: [
        Padding(
          // padding: const EdgeInsets.all(15.0),
          padding: EdgeInsets.fromLTRB(15.0,30.0,15.0,10.0),
          child: TextField(
            controller: imagineURL,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Recipe Image",
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          ),
        ),
      Padding(
      // padding: const EdgeInsets.all(15.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: TextField(
        controller: denumire,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Recipe Name",
          contentPadding:
          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ),
    ),
        Padding(
          // padding: const EdgeInsets.all(15.0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: TextField(
            controller: modPreparare,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Recipe Preparation",
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          ),
        ),
        Padding(
          // padding: const EdgeInsets.all(15.0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: TextField(
            controller: timpPregatire,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Recipe Preparation Time",
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          ),
        ),
        Padding(
          // padding: const EdgeInsets.all(15.0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: TextField(
            controller: calorii,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Recipe Calories",
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          ),
        ),
        Padding(
        // padding: const EdgeInsets.all(15.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Text("Ingredients ",textAlign:TextAlign.left,style: TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
        ),
         ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
              ...ingredients.map(buildSingleCheckBox).toList(),

          ],
        ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
              List<RecipeIngredient> recipeIngredientsList =[];
              for(int i=0;i<ingredients.length;i++){
                if(ingredients[i].value == true) {
                  RecipeIngredient x = RecipeIngredient(widget.recipeRepo.getAllRecipes().length + 1, ingredients[i].id);
                  recipeIngredientsList.add(x);
                }
              }
              String errorString="";
              if(denumire.text.isEmpty || modPreparare.text.isEmpty || timpPregatire.text.isEmpty || calorii.text.isEmpty || recipeIngredientsList.length == 0){
                errorString+="The fields must not be null!\n";
              }
              if(int.tryParse(timpPregatire.text) == null || int.tryParse(calorii.text) == null)
                errorString+="The fields RecipePreparationTime and RecipeCalories must be positive integers!\n";
              if(errorString.isNotEmpty) {
                AlertDialog alert = AlertDialog(
                  title: Text("Validation Error"),
                  content: Text(errorString),
                  actions: [
                  ],
                );
                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
              else {
              Recipe r = Recipe(
                  widget.recipeRepo.getAllRecipes().length + 1, 1, denumire.text, modPreparare.text, int.parse(timpPregatire.text), int.parse(calorii.text),
                  "https://cdn5.vectorstock.com/i/1000x1000/54/64/recipe-book-icon-outline-style-vector-36425464.jpg");

                widget.recipeRepo.addRecipe(r, recipeIngredientsList);
                widget.notifyChange();
                Navigator.pop(context);
               }
            },
              child: const Text("SAVE"),)
        ),
      ]
      )
      ],)
      // ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget buildSingleCheckBox(CheckBoxState checkBox) => CheckboxListTile(
    controlAffinity: ListTileControlAffinity.leading,
    value: checkBox.value,
    title: Text(checkBox.title),
    onChanged: (value) => setState(() => checkBox.value = value!),
  );
}


class CheckBoxState{
  final int id;
  final String title;
  bool value;
  CheckBoxState({
    required this.id,
    required this.title,
    this.value=false,
});
}