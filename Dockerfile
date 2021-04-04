FROM ubuntu

#hace falta poner estos dos comandos para levantar luego el apache, ekl TZ y el link simbolico del TZ
#porque apache pide TZ por comandos para seleccion y el -f no funciona
# los codigos aqui: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN apt-get update
RUN apt-get install -y python
RUN  echo test >> /etc/version && apt-get install -y git \
&& apt-get install -y iputils-ping
# así con json en corchete no se ejecuta en bash, y no estamos limitado por eso
#CMD ["echo","welcome to this container"]

# así sería que lo ejecuta el bash
#CMD echo "welcome to this container bash"
#CMD ["/bin/bash"]

##WORKDIR##
# Puedo tener varios, 
RUN mkdir /datos
WORKDIR /datos
RUN touch f1.txt
RUN mkdir /datos1
WORKDIR /datos1
RUN touch f2.txt&

## COPY ##
#aqui ponemos al path completo del contenedor
COPY app.log /datos
#al poner punto, hacer referencia al workdir (el ultimo)
COPY index.html .  

## ADD ##
#permite trabajar con tar, y además también urls en lugar de fichero o directorio
ADD docs docs
ADD f* /datos/
ADD f.tar .


## ENV ## puedo poner varias en la misma linea, y con && le meto más comandos en el run, al crear el contenedor
ENV dir=/data dir1=/data1
RUN mkdir $dir && mkdir $dir1

## ARG ##  puede no tener valores.  se populan al construir el contenedor
#ARG dir2
#RUN mkdir $dir2
#ARG user
#ENV user_docker $user
#ADD add_user.sh /datos1
#RUN /datos1/add_user.sh

## EXPOSE ##
#permite exponer puertos para poder ser utilizados publicamente, 
#hay que seguir usando -p  pero ayuda a la hora de crear el contenedor a ver que puertos va a necesitar para algunos de los productos.
#es mas para saber que puertos de la imagen son susceptibles de que puedan usarse
RUN apt-get install -y apache2
EXPOSE 80
ADD entrypoint.sh /datos1


## VOLUME ##
#porque se añade porque apache las sirve desde ese directorio. para mostrar entorno web en ese directorio
#y creo un volumen basado en esa directivo
ADD paginas /var/www/html
VOLUME ["var/www/html"]

## CMD ##
#¿Por que no poner run? porque los comandos que son cambiar producto estado,s ervicio no quedan con la imagen en el RUN, no queda arrancado
# una vez arrancado el contenedor, hay que hacerlo con scripts. los volumenes son externos al contenedor, recordemos

CMD /datos1/entrypoint.sh

## ENTRYPOINT ##
#ENTRYPOINT ["/bin/bash"]

