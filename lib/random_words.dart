import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './lista_righe.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = <WordPair>{};

  void aggiungi(WordPair pair) {
    setState(() {
      _savedWordPairs.add(pair);
    });
  }

  void rimuovi(WordPair pair) {
    setState(() {
      _savedWordPairs.remove(pair);
    });
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
            title: Text(pair.asPascalCase,
                style: const TextStyle(fontSize: 16.0)));
      });

      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
        color: Colors.red,
      ).toList();

      return Scaffold(
          appBar: AppBar(title: const Text('Saved WordPairs')),
          body: ListView(children: divided));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('WordPair Generator'),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: ListaRighe(
          _randomWordPairs,
          _savedWordPairs,
          aggiungi,
          rimuovi,
        ));
  }
}
