# Corso Flutter & Dart Lezione 07 - 17 - Navigazione

onGenerateRoute è un parametro di MaterialApp, che permette di associare una 
funzione da richiamare nel caso che la named route invocata non esista.
La funzione riceve in input un argomento settings che permette di sapere 
quale route è stata invocata e con che argomenti.
onUnknownRoute è un parametro di MaterialApp, che permette di associare una 
funzione da richiamare nel caso anche la funzione onGenerateRoute fallisca.