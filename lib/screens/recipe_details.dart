import 'package:captain_cook_flutter/screens/edit_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:captain_cook_flutter/domain/recipe.dart';
import 'package:captain_cook_flutter/repos/recpie_repo.dart';

import 'discover_screen.dart';
import 'my_recipes_screen.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen(
      {Key? key, required this.title, required RecipeRepo this.recipeRepo, required Recipe this.recipe})
      : super(key: key);
  final String title;
  final RecipeRepo recipeRepo;
  final Recipe recipe;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body:
      Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15.0,20.0,15.0,15.0),
            ),
            CircleAvatar(backgroundImage: NetworkImage(recipe.imagineURL),radius:70),
            Padding(
              padding: EdgeInsets.fromLTRB(15.0,20.0,15.0,15.0),
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
                recipe.denumire,
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
                recipe.modPreparare,
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
                recipe.timpPregatire.toString() + " minutes",
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
                recipe.calorii.toString(),
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
              itemCount: recipeRepo.getIngredientsForRecipe(recipe.id).length,
              // Provide a builder function. This is where the magic happens.
              // Convert each item into a widget based on the type of item it is.
              itemBuilder: (context, index) {
                final item = recipeRepo.getIngredientsForRecipe(recipe.id)[index];
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
                  builder: (context) => MyHomePage(title: 'Discover Page',recipeRepo: recipeRepo,),
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
                  builder: (context) => MyRecipesScreen(title: "My Recipes", recipeRepo: recipeRepo,),
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

