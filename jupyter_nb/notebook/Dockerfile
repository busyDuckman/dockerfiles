#-------------------------------------------------------------------------------------------------
# python notebook
#
# This is my personal python notebook space:
#  - server setup is in jupyter_notebook_config.py (including a sha1 hash of my my password)
#  - The idea is anything I make in jupyter notebook, runs in this environment.
#-------------------------------------------------------------------------------------------------

from jupyter/datascience-notebook
MAINTAINER duckman <the.duckman@gmail.com>

USER root

RUN apt-get update && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y software-properties-common

RUN add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"

RUN apt-get install -y \
    autoconf \
    automake \
    build-essential \
    build-essential \
    cmake \
    cowsay \
    git \
    htop \
    libavformat-dev \
    libboost-all-dev \
    libboost-dev \
    libcairo2-dev\
    libjasper-dev \
    libjpeg8-dev \
    libjpeg-dev \
    libopenexr-dev \
    libpng-dev \
    libpq-dev \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libtiff5-dev \
    libtiff-dev \
    pkg-config \
    unzip \
    wget \
    yasm \
    zip \
    zlib1g-dev \
    mesa-utils

# stuff that is no longer available.  
# --no-install-recommends
# libpng12-dev \

RUN pip install --upgrade pip

RUN apt-get install -y  software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean

RUN mkdir /github &&\
    chown jovyan /github


# a place for downloading repositories
WORKDIR /github

# POVRAY
RUN git clone --branch master --single-branch --depth=1 https://github.com/POV-Ray/povray.git && \
    cd /github/povray/unix && \
    ./prebuild.sh && \
    cd  /github/povray && \
    ./configure COMPILED_BY="not povray <not_povray@sharklasers.com>" && \
    make && \
    make install

ENV OPENCV_VERSION="3.4.3"
# This download is 20mins on my humble internet link, so seperating it from the build layer
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip

#-------------------------------------------------------------------------------------------------
# OpenCV
#-------------------------------------------------------------------------------------------------
# Install the latest google protobu
RUN cd /github && \
    curl -OL https://github.com/google/protobuf/releases/download/v3.2.0/protoc-3.2.0-linux-x86_64.zip && \
    unzip protoc-3.2.0-linux-x86_64.zip -d protoc3 && \
    mv protoc3/bin/* /usr/local/bin/ && \
    mv protoc3/include/* /usr/local/include/ 
    # && \
    # chwon jovyan /usr/local/bin/protoc && \
    # chwon -R jovyan /usr/local/include/google
RUN apt-get install -y libprotobuf-dev protobuf-compiler

# Source: opencv in docker: https://github.com/janza/docker-python3-opencv/blob/master/Dockerfile
# This build was playing up, despite being stable for a few months.
# looked like a protobuf issue, so added:
#  -BUILD_PROTOBUF=OFF \
#  -UPDATE_PROTO_FILES=ON \
#  -BUILD_opencv_dnn=OFF \
RUN unzip ${OPENCV_VERSION}.zip && \
    mkdir -p /github/opencv-${OPENCV_VERSION}/cmake_binary && \
    cd /github/opencv-${OPENCV_VERSION}/cmake_binary && \
    cmake -DBUILD_TIFF=ON \
    -DBUILD_opencv_java=OFF \
    -DWITH_CUDA=OFF \
    -DENABLE_AVX=OFF \
    -DWITH_OPENGL=ON \
    -DWITH_OPENCL=ON \
    -DWITH_IPP=ON \
    -DWITH_TBB=ON \
    -DWITH_EIGEN=ON \
    -DWITH_V4L=ON \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DBUILD_PROTOBUF=OFF \
    # -UPDATE_PROTO_FILES=ON \
    -DBUILD_opencv_dnn=OFF \
    -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
    -DPYTHON_EXECUTABLE=$(which python3.6) \
    -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
    -DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
    && make install
    # && rm /github/${OPENCV_VERSION}.zip \
    # && rm -r /github/opencv-${OPENCV_VERSION}

RUN apt-get install -y \
    alsa-utils \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpangoxft-1.0-0 \
	libpulse0 \
	libssl1.0.0 \
	libxss1 \
    espeak

    # libssl1.0.2 \

# python pcackages
USER jovyan
RUN pip install \
    cairocffi \
    colormath \
    baseconvert \
    opencv-python-headless \
    opencv-contrib-python-headless \
    ImageHash \
    nltk \
    pyttsx3 \
    pip-reqs \
    langdetect \
    psaw \
    defusedxml \
    tmx \
    pygame \
    cocos2d

RUN pip install --upgrade language-check
#-------------------------------------------------------------------------------------------------
# Various pip install.
# My internet is slow, so this is astaging point for new packages, without re-running the
# previous section.
#-------------------------------------------------------------------------------------------------
# RUN pip install glu

#-------------------------------------------------------------------------------------------------
# custom built pycairo
#-------------------------------------------------------------------------------------------------
# NB: This works, but for now I am using a version in my notbook folder, so I can bug fix it
# vapory (from source, because the conda version is broke and pip installs an old copy)
# RUN git clone --branch master --single-branch --depth=1 https://github.com/Zulko/vapory && \
#     pip install ./vapory


# cairocffi is a drop in replacement for pycairo that we installed above.
# RUN pip install --user git+https://github.com/pygobject/pycairo.git

#-------------------------------------------------------------------------------------------------
# pyROOT
#-------------------------------------------------------------------------------------------------
ENV ROOT_VERSION="1"


#-------------------------------------------------------------------------------------------------
# Finish up
#-------------------------------------------------------------------------------------------------
WORKDIR /github
# RUN git clone --branch master --single-branch --depth=1 https://github.com/Maluuba/nlg-eval.git
# RUN git clone --branch master --single-branch --depth=1 https://github.com/busyDuckman/nlg-eval.git &&\
#     cd nlg-eval &&\
#     pip install -e . &&\
#     ./setup.sh

# get the local config file to set login password, etc
COPY jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py
WORKDIR $HOME/work


