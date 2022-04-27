import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import './riga.dart';

class ListaRighe extends StatelessWidget {
  const ListaRighe(
      this.randomWordPairs, this.savedWordPairs, this.add, this.remove,
      {Key? key})
      : super(key: key);

  final List<WordPair> randomWordPairs;
  final Set<WordPair> savedWordPairs;
  final Function add;
  final Function remove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if (item.isOdd) return const Divider();

        final index = item ~/ 2;

        if (index >= randomWordPairs.length) {
          randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return Riga(randomWordPairs[index], savedWordPairs, add, remove);
      },
    );
  }
}
