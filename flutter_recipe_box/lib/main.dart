// // Copyright 2018 The Flutter team. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final wordPair = WordPair.random();
//     var arrRecipes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
//     var items = List<String>.generate(10000, (i) => "Item $i");
//     print(items);
//     print("here");
//     return MaterialApp(
//       home: RandomWords(),
//     );
//   }
// }

// class RandomWords extends StatefulWidget {
//   const RandomWords({Key? key}) : super(key: key);

//   @override
//   _RandomWordsState createState() => _RandomWordsState();
// }

// class _RandomWordsState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];
//   // final _biggerFont = const TextStyle(fontSize: 18.0);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Cook Book'),
//       ),
//       body: Column(children: <Widget>[
//         Container(
//           height: 200,
//           child: _buildSuggestions(),
//         ),
//         Container(
//           padding: EdgeInsets.all(16.0),
//           child: Text('Ingredients'),
//         ),
//         Container(
//           child: Text('Instructions'),
//         ),
//       ]),
//     );
//   }

//   Widget _buildSuggestions() {
//     return ListView.builder(
//         // padding: const EdgeInsets.all(16.0),
//         itemBuilder: /*1*/ (context, i) {
//       if (i.isOdd) return const Divider(); /*2*/

//       final index = i ~/ 2; /*3*/
//       if (index >= _suggestions.length) {
//         _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//       }
//       return _buildRow(_suggestions[index]);
//     });
//   }

//   // Widget _buildArray() {
//   //   return ListView.builder(
//   //     itemCount: items.length,
//   //     itemBuilder: (context, index) {
//   //       return ListTile(
//   //         title: Text(items[index]),
//   //       );
//   //     },
//   //   );
//   // }

//   Widget _buildRow(WordPair pair) {
//     return ListTile(
//       title: Text(
//         pair.asPascalCase,
//         // style: _biggerFont,
//       ),
//     );
//   }
// }

// simplar version _________________________________________________

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F'];
//     var recipeEntry = [
//       {'name': 'start'},
//       {'name': 'end'}
//     ];
//     var _recipeName = "begin";

//     void printSomething2(context) {
//       // print(yayaInout);
//       _recipeName = 'new';
//     }

//     return MaterialApp(
//       title: 'Welcome to Flutter',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Welcome to Flutter'),
//         ),
//         body: Column(children: <Widget>[
//           Container(
//             height: 150,
//             child: ListView.builder(
//                 itemCount: recipeEntry.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     child: Center(
//                         child: TextButton(
//                             // String recipeName = recipeEntry[index]['recipe'];
//                             onPressed: () =>
//                                 // printSomething2(recipeEntry[index]['name']),
//                                 // printSomething2(context),
//                                 updateText(),
//                             child:
//                                 Text('Recipe ${recipeEntry[index]['name']}'))),
//                     // child: Text(recipeEntry[index]['recipe']),
//                   );
//                 }),
//           ),
//           Container(
//             padding: EdgeInsets.all(16.0),
//             child: Text(_recipeName),
//           ),
//           Container(
//             child: Text('Instructions'),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// Widget printSomething() {
//   print("button pressed");
//   // return (const Text("hello"));
// }

// Stateful _________________________

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
