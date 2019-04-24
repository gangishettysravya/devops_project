FROM mysql:5.7

COPY flipkart_data.sql /docker-entrypoint-initdb.d