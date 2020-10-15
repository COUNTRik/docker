# base immage
FROM alpine

# run update and install nginx
RUN apk update && apk upgrade && apk add nginx

# create dir for nginx
RUN mkdir /run/nginx/

# copy our index.html
COPY index.html /var/www/localhost/htdocs/index.html

# copy our nginx configuration
COPY default.conf /etc/nginx/conf.d/default.conf

# expose ports
EXPOSE 80

# run our command
CMD ["/bin/sh", "-c", "nginx -g 'daemon off;'; nginx -s reload;"]