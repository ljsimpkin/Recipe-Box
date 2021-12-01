import 'package:flutter/material.dart';
import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Liams App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const myCookBook());
  }
}

class myCookBook extends StatefulWidget {
  const myCookBook({Key? key}) : super(key: key);

  @override
  _myCookBookState createState() => _myCookBookState();
}

class _myCookBookState extends State<myCookBook> {
  var _recipeName = "select recipe to start";
  var _recipeIngredients = "select recipe to start";
  var _recipeInstructions = "select recipe to start";

  void _updateDisplay(recipeDictionary) {
    setState(() {
      _recipeName = recipeDictionary['recipe'];
      _recipeIngredients = '${recipeDictionary['ingredients']}';
      _recipeInstructions = '${recipeDictionary['directions']}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cook Book'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              child: ListView.builder(
                  itemCount: recipeIndex.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Center(
                          child: TextButton(
                              onPressed: () =>
                                  _updateDisplay(recipeIndex[index]),
                              child: Text(
                                  'Recipe ${recipeIndex[index]['recipe']}'))),
                    );
                  }),
            ),
            Text('$_recipeName'),
            Text('$_recipeIngredients'),
            Text('$_recipeInstructions'),
          ],
        ),
      ),
    );
  }
}
