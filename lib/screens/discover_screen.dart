import 'package:captain_cook_flutter/domain/recipe.dart';
import 'package:captain_cook_flutter/domain/recipe_ingredient.dart';
import 'package:captain_cook_flutter/repos/recpie_repo.dart';
import 'package:captain_cook_flutter/screens/recipe_details.dart';
import 'package:flutter/material.dart';

import 'my_recipes_screen.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.recipeRepo}) : super(key: key);
  final String title;
  final RecipeRepo recipeRepo;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body:GridView.count(
        padding: const EdgeInsets.only(top:20),
        // crossAxisCount is the number of columns
        crossAxisCount: 2,
        // This creates two columns with two items in each column
        children: List.generate(widget.recipeRepo.getAllRecipes().length, (index) {
          return GestureDetector(
            child: Column(
              children:[
                CircleAvatar(backgroundImage: NetworkImage(widget.recipeRepo.getAllRecipes()[index].imagineURL),radius:70),
                Text(
                  widget.recipeRepo.getAllRecipes()[index].denumire,
                  style: TextStyle(height:2,fontSize: 17),
                ),
              ],
            ),
            onTap:(){
              //setState(() {});
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailsScreen(title: "Recipe Details", recipeRepo: widget.recipeRepo, recipe: widget.recipeRepo.getAllRecipes()[index],),
                ),
              );
              //print(recipeList[index].denumire);
            }
          );
        }),
      ),
      floatingActionButton://Container(

        //color:Colors.purple,
        //child:
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
      // ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
