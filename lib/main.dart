// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MusicSelector());

class MusicSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Selector',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          leading: Icon(Icons.library_music),
          title: Text(
            'Music Selector',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        actions: <Widget>[
          // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ], // ... to here.
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            // Add 6 lines from here...
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          ); // ... to here.
        },
      ), // ... to here.
    );
  }

  Widget _buildSuggestions() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: ActiveSong(song: new Song()),
        ),
        const Divider(
          color: Colors.black,
          height: 20,
          thickness: 3,
          indent: 5,
          endIndent: 5,
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.green,
          ),
        ),
      ],
    );
    // return Column(
    //   children: <Widget>[
    //     Expanded(
    //       flex: 7,
    //       child: ActiveSong(song: new Song()),
    //     ),
    //     const Divider(
    //       color: Colors.black,
    //       height: 20,
    //       thickness: 3,
    //       indent: 5,
    //       endIndent: 5,
    //     ),
    //     Expanded(
    //         child: const FlutterLogo(),
    //         // ListView.builder(
    //         //     padding: const EdgeInsets.all(16.0),
    //         //     itemBuilder: /*1*/ (context, i) {
    //         //       if (i.isOdd) return Divider(); /*2*/

    //         //       final index = i ~/ 2; /*3*/
    //         //       if (index >= _suggestions.length) {
    //         //         _suggestions.addAll(generateWordPairs().take(10)); /*4*/
    //         //       }
    //         //       return _buildRow(_suggestions[index]);
    //         //     }),
    //     ),
    //   ],
    // );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ), // ... to here.
      onTap: () {
        // Add 9 lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }, // ... to here.
    );
  }
}

class Song {
  String id;
  String person;
  String isNewGenreDay;
  String genre;
  String song;
  String thumbsUp;
  String thumbsDowm;
}

class ActiveSong extends StatelessWidget {
  final Song song;
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  ActiveSong({this.song, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Container(
        child: Center(
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text('Date: ${song.id}', overflow: TextOverflow.ellipsis),
              subtitle:
                  Text('Genre: ${song.genre}', overflow: TextOverflow.ellipsis),
            ),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 1,
            ),
            ListView(
              padding: const EdgeInsets.all(24),
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  height: 50,
                  child: Text('Who\'s Up: ${song.person}',
                      overflow: TextOverflow.ellipsis, style: _biggerFont),
                ),
                Container(
                  height: 50,
                  child: Text('Song Picked: ${song.song}',
                      overflow: TextOverflow.ellipsis, style: _biggerFont),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: <Widget>[
                            Spacer(), // Defaults to a flex of one.
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: RaisedButton(
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  if (_formKey.currentState.validate()) {
                                    // Process data.
                                  }
                                },
                                child: Text('Save'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 1,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Thumbs Up'),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: const Text('Thumbs Down'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
