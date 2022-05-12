# syntax=docker/dockerfile:1

FROM rocker/rstudio:4.2.0

WORKDIR /root

COPY requirements.r requirements.r
RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        libxml2-dev \
        libglpk-dev \
        libpq-dev \
        libssl-dev; \ 
    Rscript requirements.r

EXPOSE 8787

CMD ["/init"]
