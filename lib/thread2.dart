import 'dart:isolate';
import 'dart:math';
import 'repository.dart';
import 'dart:io';

void thred2(SendPort sendPort) {
  final t2 = Asincrono2()..run(sendPort);
}

class Asincrono {
  final receivePort = ReceivePort();
  SendPort? sendport;

  Isolate? isolate;
  int num = 1;

  Future<void> lanciaThread2(Repository repo) async {
    if (repo.getStato() == 0) {
      receivePort.listen((message) {
        if (message is SendPort) {
          sendport = message;
        } else {
          repo.addDati(message);
          sendport!.send(num++);
        }
      });
    }
    isolate = await Isolate.spawn(thred2, receivePort.sendPort);
  }

  void ferma() {
    sendport!.send('a');
    //receivePort.close();
    //isolate?.kill();
  }
}

class Asincrono2 {
  int num = 3;
  bool fine = false;

  void run(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    elabora(sendPort);
    receivePort.listen((message) {
      if (message is SendPort) {
        elabora(sendPort);
      } else {
        if (message is int) {
          num = message;
        } else {
          fine = true;
        }
      }
    });
  }

  void elabora(SendPort sendPort) async {
    final lista = <int>[];
    final rand = Random();
    while (!fine) {
      lista.clear();
      for (int i = 0; i < num; i++) {
        //lista.add(rand.nextInt(100));
        lista.add(i);
      }
      sendPort.send(lista);
      //sleep(Duration(seconds: 3));
      await Future.delayed(Duration(seconds: 3));
    }
  }
}
