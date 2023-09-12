FROM library/postgres


ENV POSTGRES_USER admin
ENV POSTGRES_PASSWORD admin
ENV POSTGRES_DB leilao

COPY BD2021_data.sql /docker-entrypoint-initdb.d/

EXPOSE 5432
