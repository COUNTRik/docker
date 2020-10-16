# DOCKER: создаем свой образ nginx на базе alpine

Создаем Dockerfile (см. Dockerfile с комментариями).
Создаем свой index.html.
Создаем свой конфигурационный файл default.conf (здесь изменен путь к index.html).

P.S. Все действия были протестированы на Vagrantfile.

Переходим в директорию *vagrant*.

	[root@docker]$ cd /vagrant/

Создаем образ на основе нашего Dockerfile

	[root@docker vagrant]# docker build . -t nginx-alpine
	Successfully built 6bbe91577756

Проверяем наличие нашего образа

	[root@docker vagrant]# docker images
	REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
	nginx-alpine        latest              6bbe91577756        23 minutes ago      10.6 MB
	docker.io/alpine    latest              a24bb4013296        4 months ago        5.57 MB

Запускаем контейнер на основе нашего образа с параметрами: запустить как демон-процесс *-d*, подлкючаем интерактивный терминал *-it*, указываем порты хоста и контейнера *-p*, задаем имя *--name*

	[root@docker vagrant]# docker run -it -d -p 80:80 --name test nginx-alpine
	cf7104dddf01ae3c1e88bacf3d2e6d5fee4cfa07168bf23dc14fe0643ce3e043

Проверяем доступ к нашей странице.

	[root@docker vagrant]# curl localhost
	<!DOCTYPE html>
	<html>

	<head>

	  <title>Hello Otus!!!</title>
	  
	  <h1>Привет Отус!!!</h1>

	</head>

	</html>

Осталось отправить наш образ в DockerHub.
Создав учетную запись мы отправляем наш образ в созданный нами репозиторий в DockerHub.
	
	[root@docker vagrant]# docker login
	[root@docker vagrant]# docker push countrik/nginx-alpine
	
Зугрузить наш образ можно командой
	
	[root@docker vagrant]# docker pull countrik/nginx-alpine

# Разница между контейнером и образом

Ответ основан на этом [материале](https://habr.com/ru/post/272145/).

+ Образ можно определить как «сущность» или «общий вид» (union view) стека слоев только для чтения.
+ Контейнер можно назвать «сущностью» стека слоев с верхним слоем для записи.
+ Запущенный контейнер — это «общий вид» контейнера для чтения-записи и его изолированного пространства процессов.

Если своими словами, то я понимаю образ как форма для печати контейнера, контейнер - это пустой контейнер со стенками и крышкой, запущенный контейнер - это контейнер с определенным грузом, который транспортируют в данный момент.

# Ядро контейнера Docker

Если я правильно понимаю, как такового ядра в контейнере нет, он испльзует ядро хоста. Фактически, запущенный контейнер это простанство процессов, которые работают со слоями контейнера, который отправляет системные вызовы ядру хоста.
