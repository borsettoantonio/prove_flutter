import 'package:flutter/cupertino.dart';
import 'thread2.dart';

class Repository extends ChangeNotifier {
  List<int> _dati = [2, 5, 8, 9];
  int statoThread = 0;
  Asincrono? asin;

  List<int> getDati() {
    return _dati;
  }

  void addDati(List<int> dat) {
    _dati += dat;
    notifyListeners();
  }

  void lanciaThread() {
    asin = Asincrono();
    asin?.lanciaThread2(this);
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
