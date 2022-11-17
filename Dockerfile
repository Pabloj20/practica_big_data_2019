FROM python:3.7.15

WORKDIR /usr/src/app

ENV PROJECT_HOME=/usr/src/app

COPY requirements.txt requirements.txt

RUN python3.7 -m pip install --upgrade pip
RUN python3.7 -m pip install -r requirements.txt
RUN python3.7 -m pip install joblib

COPY . .

CMD [ "python3.7", "./resources/web/predict_flask.py" ]
