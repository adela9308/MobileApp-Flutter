import 'package:captain_cook_flutter/repos/recpie_repo.dart';
import 'package:captain_cook_flutter/screens/discover_screen.dart';
import 'package:flutter/material.dart';

void main() {
  final RecipeRepo recipeRepo = RecipeRepo();
  runApp(MyApp(recipeRepo: recipeRepo));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key ,required this.recipeRepo}) : super(key: key);
  final RecipeRepo recipeRepo;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Captain Cook',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Discover Page',recipeRepo: recipeRepo),
    );
  }
}
