
import 'package:captain_cook_flutter/domain/ingredient.dart';
import 'package:captain_cook_flutter/domain/recipe.dart';
import 'package:captain_cook_flutter/domain/recipe_ingredient.dart';

class RecipeRepo {
  List<Recipe> recipeList=[
    Recipe(0,0,"Budinca cu ciocolata","Mod de preparare budina cu ciocolata",20,300, "https://theclevermeal.com/wp-content/uploads/2018/11/chocolate-pudding-recipe-1.jpg"),
    Recipe(1,0,"Placinta cu mere","Mod de preparare placinta cu mere",60,1200,"https://dulciurifeldefel.ro/wp-content/uploads/2016/10/placinta-impletita-cu-mere-si-stafide-1.jpg"),
    Recipe(2,0,"Macaroane cu branza","Mod de preparare macaroane cu branza",30,340,"https://www.e-retete.ro/files/recipes/macaroane-cu-branza.jpg"),
    Recipe(3,1,"*Budinca cu ciocolata","Mod de preparare budina cu ciocolata",20,300, "https://theclevermeal.com/wp-content/uploads/2018/11/chocolate-pudding-recipe-1.jpg"),
    Recipe(4,2,"Placinta cu mere","Mod de preparare placinta cu mere",60,1200,"https://dulciurifeldefel.ro/wp-content/uploads/2016/10/placinta-impletita-cu-mere-si-stafide-1.jpg"),
    Recipe(5,1,"Lava cake","Mod de preparare Lava cake",60,1200,"https://lapofticiosul.ro/wp-content/uploads/2019/11/molten-lava-cakes.jpg"),
    Recipe(6,2,"Macaroane cu branza","Mod de preparare macaroane cu branza",30,340,"https://www.e-retete.ro/files/recipes/macaroane-cu-branza.jpg"),
  ];

  List<Ingredient> ingredientsList =[
    Ingredient(0,"Sugar"), Ingredient(1,"Flour"), Ingredient(2,"Lemon"), Ingredient(3,"Milk"), Ingredient(4,"Salt"), Ingredient(5,"Oil"),
  ];
  
  List<RecipeIngredient> recipeIngredientsList=[
    RecipeIngredient(3, 1), RecipeIngredient(3, 2), RecipeIngredient(3, 5), RecipeIngredient(5, 0), RecipeIngredient(5, 3), RecipeIngredient(5, 4),
  ];

  List<Recipe> getAllRecipes(){
    return recipeList;
  }
  List<Ingredient> getAllIngredients(){
    return ingredientsList;
  }
  List<Recipe> getUsersRecipes(int userID){
    List<Recipe> list=[];
    for(int i=0;i<recipeList.length;i++){
      if(recipeList[i].userID == userID) list.add(recipeList[i]);
    }
    return list;
  }
  void addRecipe(Recipe r,List<RecipeIngredient> list){
    recipeList.add(r);
    for(int i=0;i<list.length;i++){
      recipeIngredientsList.add(list[i]);
    }
  }
  void deleteRecipe(Recipe r){
    deleteRecipeIngredient(r.id);
    int index = -1;
    for(int i=0;i<recipeList.length;i++)
    {
      if(recipeList[i].id == r.id)
        index = i;
    }
    recipeList.removeAt(index);
  }
  void updateRecipe(int recipeID,Recipe newRecipe,List<RecipeIngredient> list){
    for(int i=0;i<recipeList.length;i++)
    {
      if(recipeList[i].id == recipeID) {
        recipeList[i].denumire = newRecipe.denumire;
        recipeList[i].modPreparare = newRecipe.modPreparare;
        recipeList[i].timpPregatire = newRecipe.timpPregatire;
        recipeList[i].calorii = newRecipe.calorii;
        recipeList[i].imagineURL = newRecipe.imagineURL;
      }
    }
    deleteRecipeIngredient(recipeID);
    for(int i=0;i<list.length;i++){
      recipeIngredientsList.add(list[i]);
    }
  }
  void deleteRecipeIngredient(int recipeID){
    List<int> index =[];
    for(int i=0;i<recipeIngredientsList.length;i++)
      {
        if(recipeIngredientsList[i].recipeID == recipeID)
          index.add(i);
      }
    index = new List.from(index.reversed);
    for(int i=0;i<index.length;i++) {
      recipeIngredientsList.removeAt(index[i]);
    }
  }
  Ingredient findOneIngredient(int ingredientID){
    for(int i=0;i<ingredientsList.length;i++){
      if(ingredientsList[i].id == ingredientID) return ingredientsList[i];
    }
    return Ingredient(-1, "");
  }
  List<Ingredient> getIngredientsForRecipe(int recipeID){
    List<Ingredient> list=[];
    for(int i=0;i<recipeIngredientsList.length;i++){
      if(recipeIngredientsList[i].recipeID == recipeID){
        Ingredient x = findOneIngredient(recipeIngredientsList[i].ingredientID);
        list.add(x);
      }
    }
    return list;
  }

}