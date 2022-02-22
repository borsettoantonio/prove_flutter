import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => Repository(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Consumer<Repository>(
        builder: (context, repo, child) {
          final dati = repo.getDati();
          String numeri = '';
          for (int x in dati) {
            numeri = numeri + (x.toString() + '_ ');
          }
          return Text(numeri);
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final repo = Provider.of<Repository>(context, listen: false);
          if (repo.getStato() == 0) {
            repo.lanciaThread();
          } else {
            repo.fermaThread();
          }
          repo.cambiaStato();
        },
        tooltip: 'Increment',
        child: Consumer<Repository>(builder: (context, repo, child) {
          return repo.getStato() == 0
              ? const Icon(Icons.add)
              : const Icon(Icons.remove);
        }),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
