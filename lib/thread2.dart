import 'dart:isolate';
import 'repository.dart';

void thred2(SendPort sendPort) {
  //final t2 = Asincrono2()..run(sendPort);
  Asincrono2().run(sendPort);
}

class Asincrono {
  final receivePort = ReceivePort();
  SendPort? sendport;

  Isolate? isolate;
  int num = 1;

  Future<void> lanciaThread2(Repository repo) async {
    receivePort.listen((message) {
      if (message is SendPort) {
        sendport = message;
      } else {
        repo.addDati(message);
        sendport!.send(num++);
      }
    });
    isolate = await Isolate.spawn(thred2, receivePort.sendPort);
  }

  void ferma() {
    sendport!.send('pausa');
    num = 1;
    //receivePort.close();
    //isolate?.kill();
  }

  void continua() {
    sendport!.send('continua');
  }
}

class Asincrono2 {
  int num = 3;
  bool fine = false;
  SendPort? sendport;

  void run(SendPort sp) {
    sendport = sp;
    final receivePort = ReceivePort();
    sendport!.send(receivePort.sendPort);
    elabora();
    receivePort.listen((message) {
      if (message is int) {
        num = message;
      } else {
        if (message == "pausa")
          fine = true;
        else if (message == 'continua') elabora();
      }
    });
  }

  void elabora() async {
    fine = false;
    final lista = <int>[];
    //final rand = Random();
    while (!fine) {
      lista.clear();
      for (int i = 0; i < num; i++) {
        //lista.add(rand.nextInt(100));
        lista.add(i);
      }
      sendport!.send(lista);
      //sleep(Duration(seconds: 3));
      await Future.delayed(Duration(seconds: 3));
    }
  }
}
