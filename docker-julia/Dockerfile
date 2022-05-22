# syntax=docker/dockerfile:1

FROM julia:1.7.2

WORKDIR /root

COPY requirements.jl requirements.jl
RUN julia requirements.jl; \
    julia -e 'import Conda; Conda.add("jupyterlab")'

EXPOSE 1234

CMD ["/root/.julia/conda/3/bin/jupyter", "lab", "--allow-root", "--no-browser", "--ip=0.0.0.0", "--port=1234"]
