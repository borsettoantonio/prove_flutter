import 'package:flutter/material.dart';
import './ui/doclist.dart';

void main() => runApp(const DocExpiryApp());

class DocExpiryApp extends StatelessWidget {
  const DocExpiryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DocExpire',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const DocList(),
    );
  }
}
