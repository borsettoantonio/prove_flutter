import 'package:flutter/material.dart';

typedef foo = void Function();

class Conteggio {
  int conto = 0;
}

class CountState extends InheritedWidget {
  //final int? count;
  final Conteggio? count;
  final Widget child;
  final foo addCounter;
  final foo removeCounter;

  const CountState(
      {Key? key,
      this.count,
      required this.child,
      required this.addCounter,
      required this.removeCounter})
      : super(key: key, child: child);

  static CountState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CountState>()!);
    //return (context.findAncestorWidgetOfExactType<CountState>()!);
  }

  @override
  bool updateShouldNotify(CountState oldWidget) {
    return true;
    //return count!.conto != oldWidget.count!.conto;
  }
}

void main() {
  runApp(const MyApp());
}

class RootWidget extends StatefulWidget {
  @override
  RootWidgetState createState() => RootWidgetState();
}

class RootWidgetState extends State<RootWidget> {
  Conteggio count = Conteggio();
  void addCounter() {
    setState(() {
      count.conto++;
    });
  }

  void removeCounter() {
    setState(() {
      if (count.conto > 0) {
        count.conto--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CountState(
      count: count,
      addCounter: addCounter,
      removeCounter: removeCounter,
      child: const InheritedWidgetDemo(),
    );
  }
}

class InheritedWidgetDemo extends StatelessWidget {
  const InheritedWidgetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final counterState = CountState.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Counter Inherited Widget Demo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Testo1()
            /* Text(
              'Items add & remove: ${CountState.of(context).count}',
              style: const TextStyle(fontSize: 20),
            ) */
            ,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    onPressed: CountState.of(context).removeCounter,
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    //onPressed: CountState.of(context).addCounter,
                    onPressed: CountState.of(context).addCounter,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    //onPressed: CountState.of(context).addCounter,
                    onPressed: () {
                      CountState.of(context).count!.conto++;
                    },
                    child: const Icon(
                      Icons.access_alarm,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootWidget(),
    );
  }
}

class Testo1 extends StatelessWidget {
  Testo1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('testo1');
    return Text(
      'Items add & remove: ${CountState.of(context).count!.conto}',
      //'Items add & remove:33',
      style: const TextStyle(fontSize: 20),
    );
  }
}
