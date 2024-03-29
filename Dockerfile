# FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04
FROM opennmt/tensorflow-serving:2.1.0

WORKDIR /root

ENV PYTHONDONTWRITEBYTECODE=1
ENV LANG=C.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        # libnvinfer6=6.0.1-1+cuda10.1 \
        # libnvinfer-plugin6=6.0.1-1+cuda10.1 \
        python3-distutils \
        wget \
        && \
    wget -nv https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py && \
    apt-get autoremove -y wget && \
    rm -rf /var/lib/apt/lists/*

ADD base_requirements.txt /root
ADD requirements.txt /root
RUN python3 -m pip --no-cache-dir install -r /root/base_requirements.txt -r /root/requirements.txt

RUN apt-get update && \
    apt-get install -y zip

ADD entrypoint.py /root
ADD nmtwizard /root/nmtwizard
ENTRYPOINT ["python3", "entrypoint.py"]



# FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu16.04

# WORKDIR /root

# ENV PYTHONDONTWRITEBYTECODE=1

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#         libnvinfer6=6.0.1-1+cuda10.1 \
#         libnvinfer-plugin6=6.0.1-1+cuda10.1 \
#         python3 \
#         wget \
#         && \
#     wget -nv https://bootstrap.pypa.io/get-pip.py && \
#     python3 get-pip.py && \
#     rm get-pip.py && \
#     apt-get autoremove -y wget && \
#     rm -rf /var/lib/apt/lists/*

# RUN apt update
# RUN apt install git -y
# RUN git clone https://github.com/SYSTRAN/storages.git

# ADD requirements.txt /root/base_requirements.txt
# ADD requirements.txt /root
# RUN python3 -m pip --no-cache-dir install -r /root/base_requirements.txt -r /root/requirements.txt

# ADD entrypoint.py /root
# ADD nmtwizard /root/nmtwizard
# COPY models/test_transformer_model /root/models/

# ENTRYPOINT ["python3", "entrypoint.py"]