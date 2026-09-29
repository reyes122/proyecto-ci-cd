# 1. Base de la imagen (usamos la versión reducida de Debian 12 para ahorrar espacio)
FROM debian:bookworm-slim
#Instalacion de Parches de Seguridad
RUN DEBIAN_FRONTEND=noninteractive apt-get -o Acquire::Check-Valid-Until=false update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq && rm -rf /var/lib/apt/lists/*

# 2. Instalación de dependencias (Actualizamos, instalamos nginx y limpiamos la caché de apt para minimizar el tamaño)
RUN apt-get update && \
    apt-get install -y nginx curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Directorio de trabajo predeterminado para servidores web en Debian
WORKDIR /var/www/html

# Copiamos el código fuente de nuestro sitio web (lo crearemos en la Tarea 2)
COPY ./src .

# 3. Comandos necesarios
# Exponemos el puerto 80 para el tráfico web
EXPOSE 80

# Comando para iniciar el servidor Nginx y mantener el contenedor activo
CMD ["nginx", "-g", "daemon off;"]
