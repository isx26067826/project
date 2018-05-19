# Docker Hub

Per poguer proporcionar a qualsevol usuari l'oportunitat de poguer comprovar per si mateix els diferents metodes de autenticació que en aquest projecte
hen utilitzat, he pujat al meu repositori de Docker Hub amb el nom *nickdunaway* les imatges. Com les he pujat? En aquesta part explicare com ho he fet.

Si volen pujar al nostre repositori la imatge que volen compartir en de autenticarnos com a propietaris del nostre repositori docker. Amb la commanda 
*docker login* ho faren

```bash
docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: nickdunaway
Password: 
Login Succeeded

```

En tots les proves per comprovarels  metodes d'autenticació he utilitzat Dockerfiles (fitxer de regles i ordres per construir una imatge) i altres fitxers. Per
construir la imatge hen de utilitzar la commanda *docker build* amb el parametre *-t*, indicar el nom de la imatge i com a final la ruta on som tots els fitxers
que en aquest cas en posat un punt per que estem executant l'ordre en el lloc on son tots aquest fitxers. A continuació veuren que hen agafat com exemple la
imatge del servidor external.

```bash

docker build -t "external-server" .

```
Ara canvien el nom de la imatge, indicant el nom del repositori en el nom cas. En realitat no canvien la imatge el que fa la comanda *docker tag* es afegir
una etiqueta a la imatge pero realment no fa el canvi sino crea una altre nom que fa referencia a la mateixa imatge.

```bash

docker tag external-server docker.io/nickdunaway/external-server

```

Ara si, podren pujar la imatge que hen creat per que tothom que vulgui pugui comprovar els metodes d'autenticació.

```bash

docker push docker.io/nickdunaway/external-server

```


[Tornar al principi](https://github.com/isx26067826/project/blob/master/README.md)
