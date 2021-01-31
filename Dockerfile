FROM python:3.8-slim-buster 

ENV AWS_ACCESS_KEY=your_access_key
ENV AWS_SECRET_KEY=your_secret_key
ENV AWS_REGION=your_region

WORKDIR /home/app/
COPY . /home/app/

RUN chmod 777 /home/app/awsconfig.sh
RUN pip3 install -r requirements.txt
RUN sh awsconfig.sh

