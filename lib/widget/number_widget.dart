import 'package:flutter/material.dart';

class NumberWidget extends StatefulWidget {
  final Function aggiorna;
  final int number;
  final int index;

  const NumberWidget({
    Key key,
    this.number,
    this.index,
    this.aggiorna,
  }) : super(key: key);

  @override
  _NumberWidgetState createState() {
    print('Number: $number CreateState');
    return _NumberWidgetState();
  }
}

class _NumberWidgetState extends State<NumberWidget> {
  int number;

  @override
  void initState() {
    super.initState();

    print('Number: ${widget.number} InitState');
    number = widget.number;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Number: ${widget.number} DidChangeDependencies');
  }

  @override
  void deactivate() {
    print('Number: ${widget.number} Deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('Number: ${widget.number} Dispose');
    super.dispose();
  }

  @override
  void didUpdateWidget(NumberWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('Number: ${widget.number} DidUpdateWidget');

    if (oldWidget.number != widget.number) {
      print('Number has changed');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Number: ${widget.number} Build');
    return Container(
      height: 500,
      child: TextButton(
        child: Text(
          number.toString(),
          style: TextStyle(fontSize: 80),
        ),
        onPressed: () {
          print('Number: ${widget.number} SetState');
          widget.aggiorna(widget.index, number + 1);
          setState(() => number += 1);
        },
      ),
    );
  }
}
