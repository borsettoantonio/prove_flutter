# InheritedWidget

Dopo molti giorni e molti sforzi ho (forse) capito come funziona InheritedWidget.
Ci sono vari modi per utilizzarlo: vediamone alcuni.
Una possibilità è quella di mettere a disposizione di tutto il programma dei dati immutabili.
In questo caso, quando sono disponibili questi dati, si crea il widget (che eredita da InheritedWidget) e quindi si crea un metodo statico of, che permette di recuperare il widget stesso ( o una sua parte).
Si possono usare i metodi findAncestorWidgetOfExactType oppure dependOnInheritedWidgetOfExactType, tenendo presente che il primo non propaga eventuali cambiamenti sulla UI.
Un’altra possibilità è quella di mettere a disposizione di tutto il programma un metodo che possa accedere agli elementi un certo widget. In tal caso si crea il widget da ereditare nel widget con gli elementi cui si vuole accedere, passando un metodo che accede a questi elementi.
Un’altra possibilità è quella di usare la dependance injection, ossia mettere nel widget da ereditare una classe che implementi una certa classe astratta, in modo che qualsiasi parte del programma possa usarla.
A seconda della classe concreta con cui si crea il widget viene quindi iniettato nel programma un comportamento diverso.
Qualora si voglia poter modificare il data contenuto nel widget da ereditare, si deve creare un widget con stato (chiamiamolo A) che contenga i dati da condividere e modificare. Nel suo metodo build si crea il widget da ereditare (chiamiamolo B),  cui si passano i dati da condividere, e come child il widget che racchiude il resto dell’albero che può accedere a questi dati. Al widget B si passano anche i metodi che permettono di modificare i dati dentro ad A. In questi metodi si usa setstate() per far si che il widget A sia ricostruito. Questo provoca che venga ricostruito anche il widget B, ma con i nuovi dati.
Ora se il widget child di B è const, non verrà ricostruito quando viene ricreato B, e quindi le modifiche non si propagano al child.
 Però se nel metodo of di accesso a B si usa il metodo dependOnInheritedWidgetOfExactType succede che i widget che hanno fatto accesso a B vengono comunque ricreati, quindi con i nuovi dati di B.
Quindi invece di ricreare un intero albero conviene usare questo metodo. Nel metodo updateShouldNotify si può decidere se il nuovo valore di B è diverso dal precedente e quindi se è il caso di ricostruire i widget dipendenti.
Volendo è anche possibile evitare di ricreare i dati  da passare al widget da ereditare ad ogni modifica dei dati. Per fare questo il widget da ereditare deve contenere un riferimento ad un oggetto, che a sua volta contiene i dati.
In questo modo il widget da ereditare viene ricreato ma non i dati da passare, e i dati che referenzia possono cambiare.
Questi dati vanno quindi creati una sola volta, possono quindi essere modificati. L’unico problema di questo approccio è che updateShouldNotify non vede la creazione di un oggetto diverso, quindi per aggiornare i widget dipendenti deve sempre ritornare true.
