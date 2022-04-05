import 'package:captain_cook_flutter/domain/recipe_ingredient.dart';
import 'package:captain_cook_flutter/screens/add_recipe.dart';
import 'package:captain_cook_flutter/screens/recipe_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:captain_cook_flutter/domain/recipe.dart';
import 'package:captain_cook_flutter/repos/recpie_repo.dart';

import 'discover_screen.dart';
import 'my_recipes_details.dart';

class MyRecipesScreen extends StatefulWidget {
  const MyRecipesScreen({Key? key, required this.title,required this.recipeRepo}) : super(key: key);
  final String title;
  final RecipeRepo recipeRepo;


  @override
  State<MyRecipesScreen> createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipesScreen> {

  _MyRecipesState(){
     // print(widget.title);
    //print("alooo "+widget.recipeRepo.something().toString());
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

        children:[
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,

            children:[
              CircleAvatar(backgroundImage: NetworkImage("https://www.shareicon.net/data/512x512/2016/08/18/810275_user_512x512.png"),radius:80),
          ],),
          SizedBox(height: 15),

          IconButton(
            iconSize: 45,
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecipeScreen(title:"New Recipe",recipeRepo: widget.recipeRepo,notifyChange:() {setState(() {});},),
                ),
              );
            },
          ),
          Expanded(
          child:
          GridView.count(

            padding: const EdgeInsets.only(top:20),
            // crossAxisCount is the number of columns
            crossAxisCount: 2,
            // This creates two columns with two items in each column
            children: List.generate(  widget.recipeRepo.getUsersRecipes(1).length, (index) {
              return GestureDetector(
                  child: Column(
                    children:[
                      CircleAvatar(backgroundImage: NetworkImage(widget.recipeRepo.getUsersRecipes(1)[index].imagineURL),radius:70),
                      Text(
                        widget.recipeRepo.getUsersRecipes(1)[index].denumire,
                        style: TextStyle(height:2,fontSize: 17),
                      ),
                    ],
                  ),
                  onTap:(){
                    setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyRecipesDetailsScreen(title: "Recipe Details", recipeRepo: widget.recipeRepo, recipe:  widget.recipeRepo.getUsersRecipes(1)[index],notifyChange:() {setState(() {});},
                        ),
                      ),
                    );
                  }
              );
            }),
          ),
          ),
        ]
      ),
      floatingActionButton://Container(
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
                  builder: (context) => MyRecipesScreen(title:"My Recipes",recipeRepo: widget.recipeRepo),
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

