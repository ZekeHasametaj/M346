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
* [ ] Cleanup Script
* [x] Run Script

### Benutzung
### Schlusswort

### Vorwort
Unsere Aufgabe war es einen Zip-Ordner Abzugeben. Der Ordner sollte 2 Buckets enthalt, die mit einer Lambda Funktion verknüpft sind. Die Lambda Funktion sollte ein Bild vom Bucket1 nehmen und ihn auf den Bucket2 Laden und das Bild verkleinern. Je mehr automatisiert für den Nutzer war, desto mehr Punkte würde man bekommen.

-------

<br>

## Test 1

<br>

> **In diesem Testversuch haben wir zuerst selbst unter der eigenen Gruppe versucht, diese Aufgabe zu lösen.
<br>
Made by Sathanan**

<br>

## **Die Aufgabenstellung**
---
Richten Sie zwei Buckets auf Amazon S3 ein. Sobald ein Bild in das erste Bucket hochgeladen wird, soll automatisch, z.B. über eine Lambdafunktion eine verkleinerte Version des Bildes im
zweiten Bucket abgelegt werden.

<br>

### 1. zuerst muss man sich mit dem AWS Cli verbinden per Ubuntu

<br>


    sudo apt update
    sudo apt install curl
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    sudo apt-get install zip unzip
    unzip awscliv2.zip


![Beispiel Code](/img/Screenshot_2022-12-23_203747.png "Beispiel Code")


<br>

### 2. Für diese Aufgabe muss man zuerst 3 Buckets erstellen in dem(1. Bucket) ein Bild hochgeladen wird und in den anderen jeweils eine Lambda Funktion und das verkleinerte Bild
<br>

    aws s3 mb s3://my-upload-bucket
    aws s3 mb s3://my-resized-bucket

<br>

### 3. Um die Bildverkleinerung umzusetzen muss man mittels einer Lambda Funktion dieses Prozess steuern

<br>

    import boto3
    import os
    import tempfile
    
    from PIL import Image
    
    def handler(event, context):
        # Get S3 client
        s3 = boto3.client('s3')

    bucket = event['Records'][0]['s3']['bucket']['name']
    bucket = 'my-upload-bucket'
    key = event['Records'][0]['s3']['object']['key']

    with tempfile.TemporaryDirectory() as tmpdir:
        file_path = os.path.join(tmpdir, key)
        s3.download_file(bucket, key, file_path)

        with Image.open(file_path) as image:
            image = image.resize((128, 128))

            target_bucket = 'my-resized-bucket'


<br>

### 4. Dieses index.py Dokument muss man zipen damit man diese Funktion per Cli speichern kann

<br>

    zip -r function.zip index.py

<br>

### 5. Jetzt muss man den Funktion erstellen

<br>

    1. arn=$(aws iam get-role --role-name LabRole | grep Arn | awk -F '"' '{print $4}')
<br>

    2. aws lambda create-function --function-name resize-image --runtime python3.8 --role $arn --handler index.handler --zip-file fileb://function.zip

<br>

### 6. Erstellung des S3-Ereignis-Triggers

<br>

    aws s3api put-bucket-notification-configuration \
    --bucket my-upload-bucket \
    --notification-configuration '{
      "LambdaFunctionConfigurations": [
        {
          "LambdaFunctionArn": "<your-lambda-function-arn>",
          "Events": ["s3:ObjectCreated:*"]
        }
      ]
    }'

<br>

### 7. Jetzt sollte man per commandozeile testen ob user Bildverkleinerung Funktion benutzen können

<br>



-------

<br>

## Test 2

<br>

Buckets erstellen: <br> mit dem Befehl mb(make-bucket) haben wir einen Bucket erstellt &rarr; Befehl: aws s3 mb s3://Name-des-Buckets

Lambda erstellen: <br> aws lambda create-function \ <br>--function-name my-function \ <br>  --runtime nodejs12.x \ <br>  --handler index.handler \ <br>  --zip-file fileb://function.zip \ <br>  --role arn:aws:iam::123456789012:role/lambda-role \ <br>  --memory-size 128 \ <br>  --timeout 30

### Bearbeitung

Ich und Sathanan haben die CLI von AWS genutzt und sind schnell auf die Möglichkeit mit Ubuntu und WSL mitarbeitet

### Schlusssatz

Wir haben alles versucht und kamen zu keinem Resultat sogar mit Ihrer Hilfe. Darum arbeiteten wir als Klasse zusammen am Projekt und kamen auch dann zu keinem funktionstüchtigen Ergebnis
