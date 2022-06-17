# navigazione

Navigazione usando le Named Routes.
Usando la proprietà routes di MaterialApp si possono impostare 
delle pagine identificate da una stringa associata ad una funzione di
creazione della pagina.
In questa funzione non si possono passare i parametri di costruzione della
pagina perchè dentro alla MaterialApp non si conoscono ancora.
Quindi quando si lancia la nuova pagina con:
Navigator.of(ctx).pushNamed(...) nel parametro arguments si possono inserire
dei dati che saranno poi recuperati nella nuova pagina usando:
ModalRoute.of(context).settings.arguments as Map<String, String>;
che conterrà i dati passati.