# syntax=docker/dockerfile:1

FROM julia:1.7.2

WORKDIR /root

COPY requirements.jl requirements.jl
RUN julia requirements.jl

EXPOSE 1234

CMD ["julia", "-e", "using Pluto; Pluto.run(; host=\"0.0.0.0\", port=1234, launch_browser=false)"]
