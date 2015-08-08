FROM ubuntu:15.04

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y

RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y libc6-dev oracle-java7-installer curl

RUN mkdir /downloads
RUN wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.6.0.tar.gz https://download.elasticsearch.org/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz https://download.elasticsearch.org/logstash/logstash/logstash-1.5.2.tar.gz -P /downloads/

RUN mkdir /log
RUN tar xzf /downloads/elasticsearch-1.6.0.tar.gz -C /log
RUN tar xzf /downloads/kibana-4.1.1-linux-x64.tar.gz -C /log
RUN tar xzf /downloads/logstash-1.5.2.tar.gz -C /log
RUN rm -Rf /downloads

ADD requirements.txt requirements.txt
RUN curl https://bootstrap.pypa.io/get-pip.py | python
RUN pip install elasticsearch elasticsearch-curator

ADD elasticsearch.yml /log/elasticsearch-1.6.0/config/elasticsearch.yml
ADD logstash.conf /home/kibana/logstash.conf
ADD pattern /home/kibana/patterns/nginx.grok
ADD GeoLiteCity.dat /home/kibana/GeoLiteCity.dat

ADD start.sh start.sh
RUN chmod +x start.sh
EXPOSE 8080
EXPOSE 9200
ENTRYPOINT ./start.sh
