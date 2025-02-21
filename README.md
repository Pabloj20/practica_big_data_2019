PABLO RUBIO NOGUERA - JAVIER RAMÍREZ RUIZ - MUIRST CURSO 2022/2023

Desplegar el entorno siguiendo la instrucciones de [docker-compose](#DOCKER-COMPOSE). Será necesario instalarse previamente los requisitos e instalar las dependencias.

## Downloading Data

Once the server comes up, download the data and you are ready to go. First change directory into the `practica_big_data_2019` directory.

```
cd practica_big_data_2019
```
Now download the data.

For the [Realtime Predictive Analytics](http://datasyndrome.com/video)  run: 

```
resources/download_data.sh
```
## Installation

You need to install each component included in the architecture. 
The following list includes some links with the installation procedure for each component:

En la siguiente instalación no se han usado dockers:

 - [Intellij](https://www.jetbrains.com/help/idea/installation-guide.html) (jdk_1.8)
 Para instalar Intellij en Ubuntu se ha descargado el programa con el siguiente comando:
 ```
 https://download.jetbrains.com/idea/ideaIC-2022.2.3.tar.gz
 ```
 Después se ha descomprimido con el siguiente comando:
 ```
 tar -xvf ideaIC-2022.2.3.tar.gz
 ```
 Y la carpeta resultante la hemos movido a /opt con el siguiente comando:
 ```
 sudo mv idea-IC-222.4345.14 /opt/intellij
 ```
 
 Para instalar la jdk_1.8 se ha ejecutado el siguiente comando:
 ```
 sudo apt install openjdk-8-jdk
 ```
 
 - [Pyhton3](https://realpython.com/installing-python/) (Suggested version 3.7) 
  ```
  sudo apt install python3.7
  ```
  
 - [PIP](https://pip.pypa.io/en/stable/installing/)
 ```
 python3.7 -m pip install pip
 ```
 - [SBT](https://www.scala-sbt.org/release/docs/Setup.html) 
 
 ```
 sudo apt install sbt
 ```
 
 - [MongoDB](https://docs.mongodb.com/manual/installation/)
 Se ha importado en primer lugar la clave pública del repositorio:
 ```
 wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
 ```
 
 Luego para una instalación en Ubuntu 20.04, se ha empleado el siguiente comando:
 ```
 echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.lis
 ```
 Por último se han actualizado los repositorios:
 
 ```
 sudo apt-get update
 ```
 
 Y se ha instalado finalmente mongoDB
 ```
 sudo apt-get install -y mongodb-org
 ```
 
 Para iniciarlo se ha ejecutado el siguiente comando:
 ```
 sudo systemctl mongod start
 ```
 
 Para verificar que está funcionando se ha ejecutado el siguiente comando:
 ```
 sudo systemctl mongod status
 ```
 - [Spark](https://spark.apache.org/docs/latest/) (Mandatory version 3.1.2)
 Para su instalación, se ha descargado el siguiente fichero:
 ```
 https://mirrors.estointernet.in/apache/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz
 ```
 
 Posteriormente, se ha descomprimido con el siguiente comando:
 ```
 tar - zxvf spark-3.1.2-bin-hadoop3.2.tgz
 ```
 
 Y finalmente, se ha copiado a la carpeta /opt de la siguiente manera para que fuera reconocido en el sistema:
 ```
 sudo mv spark-3.1.2-bin-hadoop3.2 /opt/spark
 ```
 Además, se ha necesitado configurar las variables del entorno de forma permanente editando el fichero ~/.bashrc.
 Se han añadido a él las siguientes líneas:
 ```
 export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
 export SPARK_HOME=/opt/spark
 export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
 ```
 
 - [Scala](https://www.scala-lang.org)(Suggested version 2.12)
 Para instalar Scala 2.12 se han ejecutado los siguientes comandos:
 ```
 sudo apt-get remove scala-library scala
 sudo wget https://downloads.lightbend.com/scala/2.12.3/scala-2.12.3.deb
 sudo dpkg -i scala-2.12.3.deb
 ```
 - [Zookeeper](https://zookeeper.apache.org/releases.html)
 Antes de instalar Zookeeper, se ha necesitado crear un usuario nuevo con los siguientes comandos:
 ```
 useradd zookeeper -m
 usermod --shell /bin/bash zookeeper
 passwd zookeeper
 usermod -aG sudo zookeeper
 mkdir /zookeeper
 chown -R zookeeper:zookeeper /zookeeper
 ```
 
 A continuación, se ha descargado la última versión estable de Zookeeper disponible:
 ```
 wget https://www.apache.org/dyn/closer.lua/zookeeper/zookeeper-3.7.1/apache-zookeeper-3.7.1-bin.tar.gz
 tar - zxvf apache-zookeeper-3.7.1-bin.tar.gz
 sudo mv apache-zookeeper-3.7.1-bin /opt/zookeeper
 chown -R zookeeper:zookeeper /opt/zookeeper
 ```
 
 - [Kafka](https://kafka.apache.org/quickstart) (Mandatory version kafka_2.12-3.0.0)
 
 
 ### Para instalar las dependencias Python requeridas, se ha ejecutado el siguiente comando:
 ```
 python3.7 -m pip install -r requirements.txt
 ```
 ### Start Zookeeper
 
 Open a console and go to the downloaded Kafka directory and run:
 
 ```
   bin/zookeeper-server-start.sh config/zookeeper.properties
  ```
  ### Start Kafka
  
  Open a console and go to the downloaded Kafka directory and run:
  
  ```
    bin/kafka-server-start.sh config/server.properties
   ```
   open a new console in teh same directory and create a new topic :
  ```
      bin/kafka-topics.sh \
        --create \
        --bootstrap-server localhost:9092 \
        --replication-factor 1 \
        --partitions 1 \
        --topic flight_delay_classification_request
   ```
   You should see the following message:
  ```
    Created topic "flight_delay_classification_request".
  ```
  You can see the topic we created with the list topics command:
  ```
      bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
  ```
  Output:
  ```
    flight_delay_classification_request
  ```
  (Optional) You can oen a new console with a consumer in order to see the messeges sent to that topic
  ```
  bin/kafka-console-consumer.sh \
      --bootstrap-server localhost:9092 \
      --topic flight_delay_classification_request \
      --from-beginning
  ```
  ## Import the distance records to MongoDB
  Check if you have Mongo up and running:
  ```
  service mongod status
  ```
  Output:
  ```
  mongod.service - MongoDB Database Server
     Loaded: loaded (/lib/systemd/system/mongod.service; disabled; vendor preset: 
     Active: active (running) since Tue 2019-10-01 14:58:53 CEST; 2h 11min ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 7816 (mongod)
     CGroup: /system.slice/mongod.service
             └─7816 /usr/bin/mongod --config /etc/mongod.conf
  
  oct 01 14:58:53 amunoz systemd[1]: Started MongoDB Database Server.
  ```
  Una vez esté MongoDB funcionando, se ha editado el fichero import_distances.sh, y se ha modificado el comando:
  ```
  mongo agile_data_science --eval 'db.origin_dest_distances.ensureIndex({Origin: 1, Dest: 1})'

  ```
  ...por el comando:
  ```
  mongosh agile_data_science --eval 'db.origin_dest_distances.ensureIndex({Origin: 1, Dest: 1})'

  ```
  Habiéndo sustituido mongo por mongosh, se puede ejecutar el script con el siguiente comando:
  ```
  ./resources/import_distances.sh
  ```
  Output:
  ```
  2019-10-01T17:06:46.957+0200	connected to: mongodb://localhost/
  2019-10-01T17:06:47.035+0200	4696 document(s) imported successfully. 0 document(s) failed to import.
  MongoDB shell version v4.2.0
  connecting to: mongodb://127.0.0.1:27017/agile_data_science?compressors=disabled&gssapiServiceName=mongodb
  Implicit session: session { "id" : UUID("9bda4bb6-5727-4e91-8855-71db2b818232") }
  MongoDB server version: 4.2.0
  {
  	"createdCollectionAutomatically" : false,
  	"numIndexesBefore" : 1,
  	"numIndexesAfter" : 2,
  	"ok" : 1
  }

  ```
  ## Train and Save the model with PySpark mllib
  In a console go to the base directory of the cloned repo, then go to the `practica_big_data_2019` directory
  ```
    cd practica_big_data_2019
  ```
  Al haber establecido anteriormente las variables del entorno, podemos directamente ejecutar el script `train_spark_mllib_model.py`
  ```
      python3 resources/train_spark_mllib_model.py .
  ```
  As result, some files will be saved in the `models` folder 
  
  ```
  ls ../models
  
  ```   
  
  ## Run Flight Predictor
  First, you need to change the base_paht val in the MakePrediction scala class,
  change that val for the path where you clone repo is placed:
  ```
    val base_path= "/home/user/Desktop/practica_big_data_2019"
    
  ``` 
  
  Una vez cambiado el `base_path`, nos situamos en la carpeta flight_prediction, y ejecutamos los siguientes comandos:
  ```
  sbt
  compile
  package
  ```
  Una vez terminado, salimos de sbt, y comprobamos que en el directorio flight_prediction/target/scala-2.12/ está el JAR compilado.
  
  Then run the code using Intellij or spark-submit with their respective arguments. 
  
  (!) - Con Intellij:
   Para iniciar Intellij se ha ejecutado el siguiente comando:
 ```
 sudo /opt/intellij/bin/idea.sh
 ```
 
 Se destaca que este último comando debe ser ejecutado desde un sitio que permita interfaz gráfica, ya que por ssh no se podrá abrir.Para que se pueda ejecutar desde el terminal a través de la interfaz gráfica de Ubuntu. Una vez ejecutado saldrá la siguiente imágen:
 ![image](https://user-images.githubusercontent.com/116291122/201998756-98387db5-7ebf-476a-b629-b4ef0c8fb67f.png)

  Se abre el proyecto `flight_prediction`:
  ![image](https://user-images.githubusercontent.com/116291122/201999087-cc7c1c7a-1eba-4f72-a104-acfdf58b9e0d.png)
  
  Se hace clic en "Confiar en el proyecto", y se ejecuta el fichero MakePredictions.scala
  
  Se compila el proyecto y se arranca. Al arrancar nos pedirá instalar el plugin de Scala:
  ![image](https://user-images.githubusercontent.com/116291122/202000928-c2f222fd-2bd6-415c-94b4-f2871fb77b37.png)

  Una vez instalado, se reinicia Intellij, y una vez reiniciado se importa sbt. Esto último te pedirá que lo hagas de manera automática.
  Una vez se han instalado todas las dependencias que quedan, ya se podrá arrancar el programa:
  ![image](https://user-images.githubusercontent.com/116291122/202043711-000c7321-c219-40e7-97f3-bb017c0e2b1b.png)
  
  ![image](https://user-images.githubusercontent.com/116291122/202044122-9e66d5c1-f7f1-4dde-861c-ad8b0549356e.png)


  
  
  (!) - Con Spark-submit:
  - En primer lugar, se ha necesitado ejecutar un máster con el comando 
  ```
  start-master.sh -h 0.0.0.0
  ```
  - En segundo lugar, se ha ejecutado un worker con el siguiente comando:
  ```
  start-worker.sh spark://127.0.0.1:7077
  ```
  Se destaca que si el máster y el worker están dentro de la misma máquina, los comandos anteriores son válidos. Si están en distintas máquinas, hay que sustituir `127.0.0.1` por la dirección en la que el worker encuentre alcalzable al máster.
  
Please, note that in order to use spark-submit you first need to compile the code and build a JAR file using sbt. 
Una vez compilado el JAR, se usará el siguiente comando para lanzar spark-submit:
  ```
 spark-submit --master spark://127.0.0.1:7077 --deploy-mode cluster --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 /home/javier/practica_big_data_2019/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar
    
  ``` 
  De igual manera, se destaca que `127.0.0.1` tiene que ser la dirección por la que el worker encuentre al máster se alcanzable. Así mismo, ` /home/javier/practica_big_data_2019/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar` debe ser sustituído por el path en el cual el JAR está alcanzable. 
  
  Si se visita la página http://localhost:8080 , donde localhost es la dirección por la que tu navegador encuentra alcanzable al máster, accederás al web UI de Spark, donde se pueden ver los hilos trabajadores y sus correspondientes logs:
  ![image](https://user-images.githubusercontent.com/116291122/201915602-2f163b7d-649f-4ff0-9bd9-a7bd12561e74.png)

  
   Be carefull with the packages version because if you are using another version of spark, kafka or mongo you have to choose the correspondent version to your installation. This packages work with Spark 3.1.2, kafka_2.12-3.1.2 and mongo superior to 2.6
  
  ## Start the prediction request Web Application
  
  Set the `PROJECT_HOME` env variable with teh path of you cloned repository, for example:
   ```
  export PROJECT_HOME=/home/user/Desktop/practica_big_data_2019
   ```
  Go to the `web` directory under `resources` and execute the flask web application file `predict_flask.py`:
  ```
  cd practica_big_data_2019/resources/web
  python3.7 predict_flask.py
  
  ```
  Now, visit http://localhost:5000/flights/delays/predict_kafka and, for fun, open the JavaScript console. Enter a nonzero departure delay, an ISO-formatted date (I used 2016-12-25, which was in the future at the time I was writing this), a valid carrier code (use AA or DL if you don’t know one), an origin and destination (my favorite is ATL → SFO), and a valid flight number (e.g., 1519), and hit Submit. Watch the debug output in the JavaScript console as the client polls for data from the response endpoint at /flights/delays/predict/classify_realtime/response/.
  
  ![image](https://user-images.githubusercontent.com/116291122/201915445-3ed01140-6334-4129-80c9-9b3cf710605c.png)

  Quickly switch windows to your Spark console. Within 10 seconds, the length we’ve configured of a minibatch, you should see something like the following:
  
  ## Check the predictions records inserted in MongoDB
  ```
   $ mongosh
   > use agile_data_science;
   >db.flight_delay_classification_response.find();
  
  ```
  You must have a similar output as:
  
  ```
  { "_id" : ObjectId("5d8dcb105e8b5622696d6f2e"), "Origin" : "ATL", "DayOfWeek" : 6, "DayOfYear" : 360, "DayOfMonth" : 25, "Dest" : "SFO", "DepDelay" : 290, "Timestamp" : ISODate("2019-09-27T08:40:48.175Z"), "FlightDate" : ISODate("2016-12-24T23:00:00Z"), "Carrier" : "AA", "UUID" : "8e90da7e-63f5-45f9-8f3d-7d948120e5a2", "Distance" : 2139, "Route" : "ATL-SFO", "Prediction" : 3 }
  { "_id" : ObjectId("5d8dcba85e8b562d1d0f9cb8"), "Origin" : "ATL", "DayOfWeek" : 6, "DayOfYear" : 360, "DayOfMonth" : 25, "Dest" : "SFO", "DepDelay" : 291, "Timestamp" : ISODate("2019-09-27T08:43:20.222Z"), "FlightDate" : ISODate("2016-12-24T23:00:00Z"), "Carrier" : "AA", "UUID" : "d3e44ea5-d42c-4874-b5f7-e8a62b006176", "Distance" : 2139, "Route" : "ATL-SFO", "Prediction" : 3 }
  { "_id" : ObjectId("5d8dcbe05e8b562d1d0f9cba"), "Origin" : "ATL", "DayOfWeek" : 6, "DayOfYear" : 360, "DayOfMonth" : 25, "Dest" : "SFO", "DepDelay" : 5, "Timestamp" : ISODate("2019-09-27T08:44:16.432Z"), "FlightDate" : ISODate("2016-12-24T23:00:00Z"), "Carrier" : "AA", "UUID" : "a153dfb1-172d-4232-819c-8f3687af8600", "Distance" : 2139, "Route" : "ATL-SFO", "Prediction" : 1 }


```

### Train the model with Apache Airflow (optional)

- The version of Apache Airflow used is the 2.1.4 and it is installed with pip. For development it uses SQLite as database but it is not recommended for production. For the laboratory SQLite is sufficient.

- Install python libraries for Apache Airflow (suggested Python 3.7)

```shell
cd resources/airflow
python3.7 -m pip install -r requirements.txt -c constraints.txt
```
- Set the `PROJECT_HOME` env variable with the path of you cloned repository, for example:
```
export PROJECT_HOME=/home/user/Desktop/practica_big_data_2019
```

- Establece un nuevo valor en la variable PATH para que encuentre el sistema el comando airflow:
```
export PATH=$PATH:~/.local/bin
```
- Configure airflow environment

```shell
export AIRFLOW_HOME=~/airflow
mkdir $AIRFLOW_HOME/dags
mkdir $AIRFLOW_HOME/logs
mkdir $AIRFLOW_HOME/plugins

airflow users create \
    --username admin \
    --password admin \
    --firstname Jack \
    --lastname  Sparrow\
    --role Admin \
    --email example@mail.org
```

Posteriormente, para iniciar airflow, es necesario inicializar su base de datos con el siguiente comando:
```
airflow db init
```
- Start airflow scheduler and webserver
```shell
airflow webserver --port 8082
airflow scheduler
```
Vistit http://localhost:8082/home for the web version of Apache Airflow.

- The DAG is defined in `resources/airflow/setup.py`.
- **TODO**: add the DAG and execute it to train the model (see the official documentation of Apache Airflow to learn how to exectue and add a DAG with the airflow command).
Para poder añadir el DAG se ha necesitado ejecutar el siguiente comando desde la carpeta practica_big_data_2019:
```
sudo cp /resources/airflow/setup.py /home/javier/airflow/dags/ 

```
Una vez copiado, se comprueba si el DAG ha sido instalado correctamente mirando el listado de DAGS instalados con el comando `airflow dags list`.
Al final, se destaca que a través de la interfaz web se puede iniciar el DAG iniciando sesión con el usuario `admin` y la contraseña `admin`.


- **TODO**: explain the architecture of apache airflow (see the official documentation of Apache Airflow).
![image](https://user-images.githubusercontent.com/116291122/201914803-601fe608-0ee2-4474-849e-c4e602472ff0.png)

![image](https://user-images.githubusercontent.com/116291122/201914881-410fee9f-a0f8-4988-a71d-83db8e40483a.png)

- **TODO**: analyzing the setup.py: what happens if the task fails?, what is the peridocity of the task?
![image](https://user-images.githubusercontent.com/116291122/201916296-b7e0a057-674f-472d-8213-d9295174b285.png)

![image](https://user-images.githubusercontent.com/116291122/201915082-4b017406-0a1d-4436-9555-18ea3bffc134.png)

![image](https://user-images.githubusercontent.com/116291122/201916337-9cf8ba9f-f0b2-4542-a273-bd2169b29575.png)


## DOCKER:

En primer lugar, es necesario crear la **red**:
```
docker network create your-network --driver bridge
```

Se crea el docker de **mongo**:
```
docker run -d  --network fbid --name mongofbid -v /home/rubioguerapablo/practica_big_data_2019:/home/practica_big_data_2019 -p 27017:27017 mongo
```
Se ha procedido a ejecutar el comando `docker exec -w /home/practica_big_data_2019 mongofbid ./resources/import_distances.sh`

Se ha comprobado que se han importado los datos ejecutando el comando `docker exec -it mongofbid mongosh agile_data_science`, y posteriormente ejecutando `show collections`. Se ha comprobado que devolvía origin_dest_distances. 

Para instalar **Kafka 3.0.0** se han ejecutado los siguientes comandos:
```
docker run -d --name zookeeper-server \
 --network fbid \
 -p 2181:2181 \
 -e ALLOW_ANONYMOUS_LOGIN=yes \
 bitnami/zookeeper:latest
```
```
docker run -d --name kafka-server \
 --network fbid \
 -p 9092:9092 \
 -e ALLOW_PLAINTEXT_LISTENER=yes \
 -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper-server:2181 \
 -e KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CLIENT:PLAINTEXT \
 -e KAFKA_CFG_LISTENERS=CLIENT://:9092 \
 -e KAFKA_CFG_ADVERTISED_LISTENERS=CLIENT://kafka-server:9092 \
 -e KAFKA_CFG_INTER_BROKER_LISTENER_NAME=CLIENT \
 bitnami/kafka:3.0.0
```
```
docker exec kafka-server kafka-topics.sh \
 --create \
 --bootstrap-server kafka-server:9092 \
 --replication-factor 1 \
 --partitions 1 \
 --topic flight_delay_classification_request
```
Se ha comprobado que se ha creado correctamente ejecutando el comando:
```
docker exec kafka-server kafka-topics.sh --bootstrap-server kafka-server:9092 --list
```
```
docker exec kafka-server kafka-console-consumer.sh \
    --bootstrap-server kafka-server:9092 \
    --topic flight_delay_classification_request \
    --from-beginning
```

Para instalar **Spark 3.1.2**:

```
docker run -d --name spark-master \
  --network=fbid \
  -e SPARK_MODE=master \
-p 10.204.0.3:8080:8080 \
  bitnami/spark:3.1.2
```

A partir de aquí, se accede desde a la web UI a través de los equipos que encuentran alcanzable la dirección `172.18.0.5:8080`. 
En el caso de google Cloud hay que exportar el puerto 8080 para que sea visible desde fuera. Eso se hace añadiendo el comando "-p direccion_interna:8080:8080" al docker run. En este caso la dirección interna es 10.204.0.3. También será necesario abrir ese puerto. 

```
docker run -d --name spark-worker \
  --network=fbid \
  -e SPARK_MODE=worker \
-p 10.204.0.3:8081:8081 \
-v /home/rubionoguerapablo/practica_big_data_2019:/home/practica_big_data_2019 \
-v /home/rubionoguerapablo/jars_dir:/opt/bitnami/spark/.ivy2:z \
  bitnami/spark:3.1.2
```

**jars_dir** debe contener las dependencias de maven que se encuentran en /root/.ivy2.
Para que se pueda ejecutar el `spark-submit` es necesario crear dicha carpeta y darle permiso de tipo 777. El comando es sudo `chmod -R 777 jars_dir/`

```
docker exec spark-worker \
spark-submit --master spark://spark-master:7077 --deploy-mode cluster \
--packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 \
/home/practica_big_data_2019/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar
```

Para el docker de **flask** lo primero que hay que hacer es modificar dónde se encuentra kafka. En nuestro caso es en `kafka-server:9092`.
Tambien hay que cambiar la dirección de mongo que será: MongoClient('mongodb://mongofbid:27017')
En la carpeta practica_big_data_2019 se crea el siguiente Dockerfile:

```
FROM python:3.7.15

WORKDIR /usr/src/app

ENV PROJECT_HOME=/usr/src/app

COPY requirements.txt requirements.txt

RUN python3.7 -m pip install --upgrade pip
RUN python3.7 -m pip install -r requirements.txt
RUN python3.7 -m pip install joblib

COPY . .

CMD [ "python3.7", "./resources/web/predict_flask.py" ]
```

Posteriormente para crear una imagen de ese Dockerfile se ejecuta el siguiente comando:
```
docker image build -t flask_image .
```
Por último, se ejecuta el comando:
```
docker run -d --name flask_app --network fbid -p 10.204.0.3:5000:5000 -v /home/rubionoguerapablo/practica_big_data_2019:/usr/src/app flask_image
```
![image](https://user-images.githubusercontent.com/116291122/202307239-8cef8d7c-2cd8-498a-8802-c206bab7c762.png)

## DOCKER-COMPOSE

Hay que cambiar el MakePrediction.scala y predict_flask.py y poner las nuevas direcciones de mongo y kafka.

El nombre de los contenedores es practica_big_data_2019_(nombre-contenedor)_1.

Se deben [descargar los datos](#downloading-data), [entrenar el modelo](#train-and-save-the-model-with-pySpark-mllib) y [generar el jar](#run-flight-predictor).

Tambien hay que modificar en el docker-compose.yml, la especificacion de dónde se encuentra la carpeta jars_dir que se debe haber creado previamente (como se especifica en la [sección de docker](#docker)).

Por último, en el `docker-compose.yml`, los puertos de ciertos contenedores se han expuesto añadiendo primero **10.204.0.3**. Esto es así porque esa es la red interna que está utilizando Google Cloud. En caso de querer desplegar el entorno en local, es necesario borrar esa dirección ip. Por el contrario, si se va a usar otro servidor en la nube, deberá modificar dicha red interna y poner la adecuada.

Desde la carpeta del proyecto se ejecuta: `docker-compose up -d`

Una vez que se ha lanzado el docker-compose es necesario ejecutar ciertos comandos en diversos contenedores:

### **Kafka**

```
docker exec practica_big_data_2019_kafka-server_1 kafka-topics.sh --create \
 --bootstrap-server practica_big_data_2019_kafka-server_1:9092 \
 --replication-factor 1 \
 --partitions 1 \
 --topic flight_delay_classification_request
```

Si se quiere lanzar un consumer:

```
docker exec practica_big_data_2019_kafka-server_1 kafka-console-consumer.sh \
 --bootstrap-server practica_big_data_2019_kafka-server_1:9092 \
 --topic flight_delay_classification_request \
 --from-beginning
```
 
### **Mongo**
 
`docker exec -w /home/practica_big_data_2019 practica_big_data_2019_mongo_1 ./resources/import_distances.sh`
 
### **Spark-Worker**
 
```
docker exec practica_big_data_2019_spark-worker_1 \
 spark-submit --master spark://spark-master:7077 --deploy-mode cluster \
 --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 \
 /home/practica_big_data_2019/flight_prediction/target/scala-2.12/flight_prediction_2.12-0.1.jar
```






