# Corso Flutter & Dart Lezione 10 - 11 Scrittura su database
13.12.2022

Creazione di un database firebase Realtime Database.
Scrittura di nuovi elementi sul database con http.post(...)
Uso di  CircularProgressIndicator() in attesa della scrittura su database remoto.
Gestione degli errori provenienti da Future.
ATTENZIONE!!!! Su edit_product_screen.dart c'è un punto doce viene mostrato un errore 
usando showDialog(). Bisogna usare showDialog<NULL>(...) altrimenti il tutto non funziona.