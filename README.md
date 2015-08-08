Bygges lokalt med
```
cdo docker
docker build -t oslokommune/kibana-nginx logging/
```

Eskporteres med:
```
docker save oslokommune/kibana-nginx > kibana-nginx.tar
```

Sender fil til serveren, også importers med:
```
sudo docker load < kibana-nginx.tar
```

Kibana startes da med:
```
sudo docker run -d --name kibana-nginx -v /var/log/itas:/var/log/itas:rw -v /home/kibana/elasticsearch-data:/data:rw -v /home/kibana/kibana-config:/home/kibana -p 15601:15601 -p 9200:9200 oslokommune/kibana-nginx
``` 
