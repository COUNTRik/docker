FROM alpine:3.12
RUN apk update && apk upgrade && && apk install nginx && apk add bash
CMD ["/bin/bash"]