# Flutter Tutorial - Stateful Widget Lifecycle
Esempio tratto da youtube: https://www.youtube.com/watch?v=FL_U8ORv-2Q 
con github: https://github.com/JohannesMilke/statefulwidget_lifecycle_example

mostra l'uso di didUpdateWidget() quando viene ricreato un widget statefull:
la creazione provoca una nuova assegnazione alle proprietà final del widget
mentre lo stato che è contenuto dello State<widget> non viene modificato.

Si vede anche che nella listview quando un elemento esce dal video viene distrutto
del tutto e ricreato quando si ripresenta sul video.
Questo fa perdere lo stato dell'elemento.