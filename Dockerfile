FROM ubuntu:24.04

RUN apt-get update && apt-get install -y nginx

COPY index.html /var/www/html/index.html
ENV app_name = 'my docker app'
ENV host_env = 'prod'

HEALTHCHECK CMD curl --fail http://localhost -- retries=3 --interval=5s  | exit 1
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
