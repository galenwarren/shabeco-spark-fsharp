FROM ubuntu:xenial

ENV SPARK_VERSION spark-2.0.2-bin-hadoop2.7
ENV MOBIUS_URL https://github.com/Microsoft/Mobius/releases/download/v2.0.200/spark-clr_2.11-2.0.200.zip
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre
ENV SPARK_HOME /opt/spark
ENV SPARKCLR_HOME /opt/mobius/runtime
ENV PYSPARK_PYTHON=python

USER root

WORKDIR /opt

RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF &&\
  echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | tee /etc/apt/sources.list.d/mono-official.list

RUN apt-get -q update && apt-get -q install -y --no-install-recommends \
  ca-certificates \
  fsharp \
  openjdk-8-jre \
  mono-devel \
  python \
  unzip \
  wget \
&& rm -rf /var/lib/apt/lists/*

RUN \
  wget -qO- https://d3kbcqa49mib13.cloudfront.net/$SPARK_VERSION.tgz | tar zxf - &&\
  mv $SPARK_VERSION spark

RUN \
  wget -q $MOBIUS_URL -O mobius.zip &&\
  unzip mobius.zip -d mobius &&\
  chmod 755 mobius/runtime/scripts/* &&\
  rm mobius.zip

CMD ["spark/bin/pyspark"]
