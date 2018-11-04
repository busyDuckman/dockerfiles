#!/bin/bash
docker build -t cpu_notebook .
docker run -it -p 8888:8888 -v /home/duckman/Notebooks/:/home/jovyan/work cpu_notebook