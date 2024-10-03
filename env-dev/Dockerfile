FROM postgres:14

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=example_db

# Copy SQL scripts into the Docker container
COPY ./project1 /docker-entrypoint-initdb.d/

# Run SQL scripts in sorted order and flatten the directory structure
RUN mkdir -p /ktmp && \
    find /docker-entrypoint-initdb.d/ -type f -name '*.sql' | sort -V | while read sqlfile; do \
        folder_name=$(basename "$(dirname "$sqlfile")"); \
        file_name=$(basename "$sqlfile"); \
        new_filename="${folder_name}-${file_name}"; \
        mv "$sqlfile" "/ktmp/$new_filename"; \
    done && \
    mv /ktmp/*.sql /docker-entrypoint-initdb.d/
