FROM nginx:alpine

# Копируем конфигурацию NGINX
COPY nginx.conf /etc/nginx/nginx.conf

# Создаем папку для статических файлов
RUN mkdir -p /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]