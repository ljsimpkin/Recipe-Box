import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

import 'data.dart';
// import 'sqlite.dart';

void main() async {
  // List data = await dataBase();
  // print('here inside main ${await data}');
  runApp(const MyApp());
  // ignore: avoid_print
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _recipeName = "Scroll and select a recipe";
  var _recipeIngredients = "Scroll and select a recipe";
  var _recipeInstructions = "Scroll and select a recipe";

  int highlightedRecipeIndex = 0;

// Main outline/Scaffold of the app structure
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cook Book'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildScrollBar(),
              buildRecipeInfo(),
              buildButtons(),
            ]),
      ),
    );
  }

  void _updateDisplay(index) {
    setState(() {
      _recipeName = '${recipeIndex[index]['recipe']}';
      _recipeIngredients = '${recipeIndex[index]['ingredients']}';
      _recipeInstructions = '${recipeIndex[index]['directions']}';
      highlightedRecipeIndex = index;
      print(index);
    });
  }

  void _updateScrollBarState() {
    setState(() {
      buildScrollBar();
    });
  }

  // widget that builds the scrollbar for selecting recipes to display
  Widget buildScrollBar() {
    return Container(
      height: 150,
      child: ListView.builder(
        itemCount: recipeIndex.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: TextButton(
              onPressed: () => _updateDisplay(index),
              child: Text('${recipeIndex[index]['recipe']}'),
            ),
          );
        },
      ),
    );
  }

  //Builds the recipe name, ingredients and description layout
  Widget buildRecipeInfo() {
    return Container(
        child: Column(
      children: [
        Text('$_recipeName', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('\n$_recipeIngredients'),
        Text('\n$_recipeInstructions'),
      ],
    ));
  }

  // form that adds new recipes to the database
  Widget inputForm() {
    String tmpTextTmp = "";
    String tmpRecipe = "";
    String tmpIngredients = "";
    String tmpDirections = "";

    return Container(
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add new recipe\n'),
            TextField(
              onChanged: (text) {
                tmpRecipe = text;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'name',
              ),
            ),
            TextField(
              onChanged: (text) {
                tmpIngredients = text;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingredients',
              ),
            ),
            TextField(
              onChanged: (text) {
                tmpDirections = text;
                print(text);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Directions',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                var newEntry = {
                  'recipe': tmpRecipe,
                  'ingredients': tmpIngredients,
                  'directions': tmpDirections,
                };
                recipeIndex.add(newEntry);
                _updateScrollBarState();
              },
              child: const Text('Submit'),
            ),
          ],
        ));
  }

  void deleteRecipe() {
    if (recipeIndex.length > 0) {
      print('inside delete function');
      recipeIndex.removeAt(highlightedRecipeIndex);
      _updateScrollBarState;
    }
  }

  // widget that builds add, edit and delete buttons
  Widget buildButtons() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return inputForm();
                },
              );
            },
            icon: Icon(Icons.add)),
        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        IconButton(
            onPressed: () {
              child:
              deleteRecipe();
            },
            icon: Icon(Icons.delete))
      ],
    ));
  }
}
