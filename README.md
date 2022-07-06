# Corso Flutter & Dart Lezione 07 - 23 Popping Pages & Passing Data Back

Come ritornare dei dati alla chiusura di una pagina.
I metodi push ritornano un Future che si completa al pop
della pagina, e con il metodo then è possibile ricevere il dato
passato dalla pagina che si chiude.
La lista dei meals di una categoria viene creata quando si costruisce la pagina della categoria. Quindi se vene eliminato un meal, questo viene tolto dalla lista.
Ora la lista non può essere costruita 
nel metodo init, perchè in esso non è ancora disponibile il buildcontext.
Allora lo si può fare nel metodo didChangeDependencies().
Però quando cambia lo stato (con setState) il metodo viene richiamato e quindi verrebbero rimessi in lista di nuovo tutti i meals anche quello appena cancellato.
Allora dobbiamo eseguire il caricamneto della lista dei meals solo la prima volta che viene creata la pagina.