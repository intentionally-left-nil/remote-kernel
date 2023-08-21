FROM continuumio/miniconda3:master-alpine
RUN apk add --update --no-cache socat bash

RUN conda config --set auto_activate_base false

# Setup environment
COPY environment.yml /root/environment.yml
RUN conda env create --file /root/environment.yml
SHELL ["conda", "run", "--no-capture-output", "-n", "kernel", "/bin/bash", "-c"]
RUN echo "conda activate kernel" >> /root/.bashrc

RUN mkdir -p /root/socks
COPY repl.py /root/repl.py

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "kernel", "python"]
CMD [                         \
    "-m",                     \
    "ipykernel_launcher",     \
    "--transport=ipc",        \
    "--no-secure",            \ 
    "--shell=10",             \
    "--iopub=11",             \ 
    "--stdin=12",             \
    "--control=13",           \
    "--hb=14",                \
    "-f=/root/socks/conn.json"\
  ]
