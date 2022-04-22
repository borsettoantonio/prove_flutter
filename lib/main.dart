import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> listSearch = [];
  bool isLoading = true;
  int counter = 0;
  Future getData() async {
    //var data = await http.get('http://10.0.2.2/DBCON/search.php');
    await Future.delayed(const Duration(seconds: 3), () {});

    // Multi-line strings are now supported!
    // Just use a triple quote (''' or """),
    // with either single quote or double quote.
    // Note the initial newline is ignored, but the last newline is not ignored!
    String jsonString = '''
    [
      {"NAME": "Samsung A30"},
      {"NAME": "Samsung Note20"}
    ]
    ''';
    // String jsonString1 = '['
    //     '{"NAME": "Samsung A30"},'
    //     '{"NAME": "Samsung Note20"}'
    //     ' ]    ';

    http.Response data = http.Response(jsonString, 200);
    var databody = jsonDecode(data.body);
    listSearch.clear();
    for (int i = 0; i < databody.length; i++) {
      listSearch.add(databody[i]['NAME']);
    }
    listSearch.add(counter.toString());
    //print(listSearch);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Caricamento asincrono di dati'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: listSearch.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(listSearch[index]),
                    ],
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            counter++;
            getData();
            setState(() {
              isLoading = true;
            });
          },
          tooltip: 'Aggiungi',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
