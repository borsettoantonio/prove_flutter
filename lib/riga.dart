import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Riga extends StatelessWidget {
  const Riga(this.pair, this.savedWordPairs, this.add, this.remove, {Key? key})
      : super(key: key);

  final WordPair pair;
  final Set<WordPair> savedWordPairs;
  final Function add;
  final Function remove;

  @override
  Widget build(BuildContext context) {
    final alreadySaved = savedWordPairs.contains(pair);

    return ListTile(
        title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18.0)),
        trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null),
        onTap: () {
          if (alreadySaved) {
            remove(pair);
          } else {
            add(pair);
          }
        });
  }
}
