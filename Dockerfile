FROM ubuntu:17.10

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    default-jre

RUN apt-get install -y wget

RUN pip3 install py4j \
    jupyter \
    matplotlib \
    pandas \
    sklearn

RUN cd /tmp/;\
    wget https://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz \
    --progress=dot;\
    mkdir /opt/spark;\
    cd /opt/spark/;\
    tar -xzf /tmp/spark-2.1.1-bin-hadoop2.7.tgz;\
    rm /tmp/spark-2.1.1-bin-hadoop2.7.tgz

RUN groupadd -r course && useradd -ms /bin/bash -g course course

USER course
WORKDIR /home/course

ENV PYSPARK_PYTHON "python3"
ENV PYTHONPATH "/opt/spark/spark-2.1.1-bin-hadoop2.7/python"

EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser"]
