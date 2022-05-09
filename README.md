# Flutter Tutorial - Stateful Widget Lifecycle vers.2

Ho modificato l'esempio con lo stesso titolo per inserire il mantenimento
dello stato negli elementi della listview che vengono cancellati perchè
non più sul video.

Su first_page.dart ci sono due versini della listview:
la prima non mantiene lo stato dei widget che vanno fuori schermo
perchè i widget non vengono ricreati a partire dal metodo lista.map(..)
la seconda invece mantiene lo stato e quando serve viene richiamato
il metodo itemBuilder.
