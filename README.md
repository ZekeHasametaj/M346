# 📌 M346 PA :: Bildverkleinerung
Willkommen zu der offiziellen Dokumentation über unsere Projektarbeit für das Modul 346, Bildverkleinerung.

## **Inhalt**
[🔹 Vorwort](#vorwort)
<br>
[🔹 Installation](#to-do)
<br>
[🔹 Benutzung](#benutzung)
<br>
[🔹 Schlusswort](#schlusswort)

### To-Do
* [ ] Setup Script
* [x] Cleanup Script
* [ ] Run Script
### Installation
### Benutzung
### Schlusswort

### Vorwort
Unsere Aufgabe war es einen Zip-Ordner Abzugeben. Der Ordner sollte 2 Buckets enthalt, die mit einer Lambda Funktion verknüpft sind. Die Lambda Funktion sollte ein Bild vom Bucket1 nehmen und ihn auf den Bucket2 Laden und das Bild verkleinern. Je mehr automatisiert für den Nutzer war, desto mehr Punkte würde man bekommen.

Buckets erstellen
: mit dem Befehl mb(make-bucket) haben wir einen Bucket erstellt &rarr; Befehl: aws s3 mb s3://Name-des-Buckets

Lambda erstellen
: aws lambda create-function \ <br>--function-name my-function \ <br>  --runtime nodejs12.x \ <br>  --handler index.handler \ <br>  --zip-file fileb://function.zip \ <br>  --role arn:aws:iam::123456789012:role/lambda-role \ <br>  --memory-size 128 \ <br>  --timeout 30
