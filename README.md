# Corso Flutter & Dart Lezione 05 - 10
Programma demo del corso 

Sommario
MediaQuery.of(context).size.height = altezza dello schermo.
appBar.preferredSize.height = altezza della appBar.
MediaQuery.of(context).padding.top = altezza della parte superiore
    dedicata as Android.
LayoutBuilder( builder: (ctx, constraints) { widget  }
    permette attraverso i constraints di conoscere le dimensioni del
    widget come vincolato dal suo parent.
FittedBox(child: Text(...),) per ridimensionare automaticamente il Text 
    in modo che sia contenuto nelle dimensioni disponibili.
    Crea un widget che ridimensiona il suo child dentro se stesso in accordo col parametro fit.

WidgetsFlutterBinding.ensureInitialized();
SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitUp,]); serve a bloccare l'orientazione landscape.

final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    test per determinare l'orienramento.

Gestione della dimensione della finestra modale ottenuta con
    showModalBottomSheet(...) 
    1° metodo
    in new_trassaction il Container del form deve avere il padding 
     bottom: MediaQuery.of(context).viewInsets.bottom + 40,
     e poi si deve racchiudere tutto dentro un SingleChildScrollView.
     In tal modo la piccola parte del form non nascosta dalla tastiera è scrollabile.
     2° metodo
     in main.dart dove si crea il form con showModalBottomSheet, si mette 
     il parametro  isScrollControlled: true, che mostra il form a schermo intero; quindi si aggiunge il widget FractionallySizedBox(...) che riduce
     la dimensione del form.

   