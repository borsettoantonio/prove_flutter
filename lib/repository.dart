import 'package:flutter/cupertino.dart';
import 'thread2.dart';

class Repository extends ChangeNotifier {
  List<int> _dati = [2, 5, 8, 9];
  int statoThread = 0;
  Asincrono? asin;
  bool primaVolta=true;

  List<int> getDati() {
    return _dati;
  }

  void addDati(List<int> dat) {
    _dati += dat;
    notifyListeners();
  }

  void lanciaThread() {
    if(primaVolta)
   { asin = Asincrono();
    asin?.lanciaThread2(this);
    primaVolta=false;
   }
   else
   asin!.continua();
  }

  void fermaThread() {
    asin?.ferma();
    _dati = [];
    notifyListeners();
  }

  int cambiaStato() {
    final stato = statoThread;
    if (statoThread == 0) {
      statoThread = 1;
    } else {
      statoThread = 0;
    }
    notifyListeners();
    return stato;
  }

  int getStato() {
    return statoThread;
  }
}
