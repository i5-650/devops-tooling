FROM postgres:14

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=example_db

# Copy SQL scripts into the Docker container
# Note: you can add as many project as you want
COPY ./project1 /docker-entrypoint-initdb.d/project1
COPY ./project2 /docker-entrypoint-initdb.d/project2


# Run SQL scripts in sorted order and flatten the directory structure
RUN i=1; \
    find /docker-entrypoint-initdb.d/ -type f -name '*.sql' | sort -V | while read sqlfile; do \
    folder_name=$(basename "$(dirname "$sqlfile")"); \
    file_name=$(basename "$sqlfile"); \
    # Formater le numéro avec left-pad (5 chiffres, zéros à gauche)
    padded_number=$(printf "%05d" "$i"); \
    new_filename="${padded_number}-${folder_name}-${file_name}"; \
    mv "$sqlfile" "/docker-entrypoint-initdb.d/$new_filename"; \
    i=$((i + 1)); \
    done && \
    chmod +r /docker-entrypoint-initdb.d/*.sql
