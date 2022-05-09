import 'package:flutter/material.dart';
//import 'package:statefulwidget_lifecycle_example/page/second_page.dart';
import 'package:statefulwidget_lifecycle_example/widget/number_widget.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int number = 1;
  List<int> lista = [for (var i = 0; i <= 9; i++) i];

  void update(int index, int val) {
    lista[index] = val;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('First Page'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() => number += 1),
            ),
          ],
        ),
        body:
            /*  Non mantiene lo stato dei widget che vanno fuori schermo
      ListView(
        children: lista
            .map((index) => NumberWidget(
                  number: lista[index],
                  index: index,
                  aggiorna: update,
                ))
            .toList(),
      )
      */

            ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => Divider(color: Colors.black),
          itemBuilder: (context, index) {
            return NumberWidget(
              number: lista[index],
              index: index,
              aggiorna: update,
            );
          },
        ),
      );
}
