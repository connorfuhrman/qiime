FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV QIIME2_RELEASE=2022.2

RUN apt update && apt -y upgrade

# Install miniconda
RUN apt install -y wget && \
    wget -O /tmp/miniconda_install.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh && \
    bash /tmp/miniconda_install.sh -b -p /opt/conda
ENV PATH=/opt/conda/bin:$PATH

# Install qiime2
RUN conda update -y conda && conda install -y anaconda-client -n base && \
    wget -O /tmp/qiime2_pkg.yml https://data.qiime2.org/distro/core/qiime2-${QIIME2_RELEASE}-py38-linux-conda.yml &&\
    conda env create -n qiime2 --file /tmp/qiime2_pkg.yml
RUN conda init bash
# RUN /bin/bash -c "conda activate qiime2"
# RUN qiime dev refresh-cache
RUN echo "conda activate qiime2" >> $HOME/.bashrc
#RUN echo "source tab-qiime" >> $HOME/.bashrc
SHELL ["/bin/bash", "--login", "-c"]
RUN qiime dev refresh-cache

# Install x11 dependencies and set up x11 through docker for grpahics
# TODO


CMD ["/bin/bash"]
