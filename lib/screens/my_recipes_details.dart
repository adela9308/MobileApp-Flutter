import 'package:captain_cook_flutter/screens/edit_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:captain_cook_flutter/domain/recipe.dart';
import 'package:captain_cook_flutter/repos/recpie_repo.dart';

import 'discover_screen.dart';
import 'my_recipes_screen.dart';

class MyRecipesDetailsScreen extends StatefulWidget {
  const MyRecipesDetailsScreen(
      {Key? key, required this.title, required RecipeRepo this.recipeRepo, required Recipe this.recipe, required Function() this.notifyChange})
      : super(key: key);
  final String title;
  final RecipeRepo recipeRepo;
  final Recipe recipe;
  final Function() notifyChange;

  @override
  State<MyRecipesDetailsScreen> createState() => _MyRecipesDetailsState();
}
class _MyRecipesDetailsState extends State<MyRecipesDetailsScreen> {

  dialogBox(BuildContext context) {
    // set up the buttons
    Widget cancelBtn = FlatButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueBtn = FlatButton(
      child: Text("Yes"),
      onPressed:  () {
        widget.recipeRepo.deleteRecipe(widget.recipe);
        widget.notifyChange();
        int count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Delete Recipe"),
      content: Text("Are you sure you want to delete the this recipe?"),
      actions: [
        cancelBtn,
        continueBtn,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body:
      Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  IconButton(onPressed: (){
                    dialogBox(context);
                  },
                    icon: Icon(Icons.delete),
                    iconSize: 40,
                  ),
                  IconButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditRecipeScreen(title: "Edit Recipe", recipeRepo: widget.recipeRepo, recipe: widget.recipe, notifyChange:widget.notifyChange),
                      ),
                    );
                  },
                    icon: Icon(Icons.edit),
                    iconSize: 40,
                  ),
                ]),
            Padding(
              padding: EdgeInsets.fromLTRB(15.0,0.0,15.0,15.0),
            ),
            CircleAvatar(backgroundImage: NetworkImage(widget.recipe.imagineURL),radius:70),
            Padding(
              padding: EdgeInsets.fromLTRB(15.0,10.0,15.0,15.0),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Icon(Icons.food_bank,size: 30,),
                Text("Recipe Name",style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.double,fontSize: 20),),
              ],),
            SizedBox(height:10),
            Text(
                widget.recipe.denumire,
                style:TextStyle(color: Colors.grey,fontSize: 18)
            ),



            Padding(
              padding: EdgeInsets.fromLTRB(15.0,0.0,15.0,15.0),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Icon(Icons.auto_awesome,size: 30,),
                Text("Recipe Preparation",style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.double,fontSize: 20),),
              ],),
            SizedBox(height:10),
            Text(
                widget.recipe.modPreparare,
                style:TextStyle(color: Colors.grey,fontSize: 18)
            ),


            Padding(
              padding: EdgeInsets.fromLTRB(15.0,0.0,15.0,15.0),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Icon(Icons.access_alarms,size: 30,),
                Text("Recipe Time Preparation",
                  style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.double,fontSize: 20),),
              ],),
            SizedBox(height:10),
            Text(
                widget.recipe.timpPregatire.toString() + " minutes",
                style:TextStyle(color: Colors.grey,fontSize: 18)
            ),


            Padding(
              padding: EdgeInsets.fromLTRB(15.0,0.0,15.0,15.0),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Icon(Icons.workspaces,size: 30,),
                Text("Recipe Calories",
                  style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.double,fontSize: 20),),
              ],),
            SizedBox(height:10),
            Text(
                widget.recipe.calorii.toString(),
                style:TextStyle(color: Colors.grey,fontSize: 18)
            ),



            Padding(
              padding: EdgeInsets.fromLTRB(15.0,0.0,15.0,15.0),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Icon(Icons.explore,size: 30,),
                Text("Recipe Ingredients",
                  style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.double,fontSize: 20),),
              ],),
            SizedBox(height:10),
            Center(
              child:
              ListView.builder(
                //Vertical viewport was given unbounded height.
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                // Let the ListView know how many items it needs to build.
                itemCount: widget.recipeRepo.getIngredientsForRecipe(widget.recipe.id).length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final item = widget.recipeRepo.getIngredientsForRecipe(widget.recipe.id)[index];
                  //IconButton(onPressed: (){},icon: Icon(Icons.add));
                  return Center( child: Text(item.denumire, style:TextStyle(color: Colors.grey,fontSize: 18)));
                },
              ),
            ),

          ]
      ),
      floatingActionButton:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children:[

          FloatingActionButton(
            heroTag: "btn1",
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'Discover Page',recipeRepo: widget.recipeRepo,),
                ),
              );
            },
            child: const Icon(Icons.manage_search),

          ),

          FloatingActionButton(
            heroTag: "btn2",
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyRecipesScreen(title: "My Recipes", recipeRepo: widget.recipeRepo),
                ),
              );
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.favorite),
          ),
        ],
      ),

    );
  }
}

