# asincrono

Esempio di come richiamare una metodo asincrono nella costruzione di 
una finestra.
Il metodo asincrono carica i dati in una variabile globale della finestra.
Quando viene invocato si deve porre a true una variabile isLoading,
che verrà posta a false alla fine del metodo asincrono dentro un setState in modo da triggerare la rebuild della finestra.
La visualizzazione dei dati sarà poi condizionata dalla variabile isLoading.