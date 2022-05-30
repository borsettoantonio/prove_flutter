import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal,
      {Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                //child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
                child: Text('€${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),

            // questa SizedBox non funziona per dare le dimensioni
            // alle due barre (grigia e colorata)
            // SizedBox(
            //   height: 60,
            //   width: 10,
            //   child:

            // prima versione funzionante
            // Stack(
            //   children: <Widget>[
            //     Container(
            //       height: 60,
            //       width: 10,
            //       decoration: BoxDecoration(
            //         border: Border.all(color: Colors.grey, width: 1.0),
            //         color: const Color.fromRGBO(220, 220, 220, 1),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     Container(
            //       height: 60,
            //       width: 10,
            //       child: FractionallySizedBox(
            //         alignment: FractionalOffset.bottomCenter,
            //         heightFactor: spendingPctOfTotal,
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: Theme.of(context)
            //                 .colorScheme
            //                 .primary, //Theme.of(context).primaryColor,
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            //),

            // seconda versione funzionante

            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: const Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FractionallySizedBox(
                alignment: FractionalOffset.bottomCenter,
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary, //Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
