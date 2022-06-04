# syntax=docker/dockerfile:1

FROM rocker/rstudio:4.2.0

WORKDIR /home/rstudio

COPY requirements.r requirements.r
RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        libglpk-dev \
        libmariadb-dev \
        libpq-dev \
        libssl-dev \
        libxml2-dev; \
    su - rstudio -c "Rscript requirements.r"

EXPOSE 8787

CMD ["/init"]
