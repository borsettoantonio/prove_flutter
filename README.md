# Corso Flutter & Dart Lezione 07 - 28  Adding Favorite Logic with Provider

Aggiunta della possibilità di scegliere dei favoriti.
L'app presentava un problema nella versione precedente: quando si toglie un favorito dalla lista,
se si stava esaminando i favoriti, questo non viene eliminato subito.
Infatti chiudendo la pagina di dettaglio del favorito si torna alla lista dei favoriti che non viene aggiornata.
Il problema viene corretto con l'uso dei provider.
I dati da condividere sono i favoriti. La classe Favoriti estende ChangeNotifier in modo da poter notificare i suoi osservatori.
In main.dart ho inserito ChangeNotifierProvider che fornisce i Favoriti a tutti i widget discendenti.
In FavoritesScreen ho inserito context.watch<Favoriti>() che mi permette di recuperare i favoriti e ricostruire lo screen quando questi cambiano.
In MealDetailScreen con context.watch<Favoriti>() posso disegnare l'icona adeguata per il pulsante dei favoriti (set/reset) e se  c'è una variazione il pulsante viene ricostruito.
Inoltre con context.read<Favoriti>().toggleFavorite(mealId); come azione del pulsante, posso comandare la variazione dei favoriti. 
