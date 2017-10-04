FROM ubuntu

MAINTAINER Marc Chevrette <chevrette@wisc>

RUN apt-get update
RUN apt-get install -y wget bzip2
RUN wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
RUN sh Miniconda2-latest-Linux-x86_64.sh -b -p /miniconda2
ENV PATH=$PATH:/miniconda2/bin
RUN conda config --add channels defaults
RUN conda config --add channels conda-forge
RUN conda config --add channels bioconda
RUN conda install -y antismash
RUN conda install -y icu=58
RUN download-antismash-databases
RUN chmod 777 /miniconda2/bin/antismash