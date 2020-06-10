FROM bluedata/centos7:4.2
LABEL maintainer="dietrich.zinsou@hpe.com"

ENV HADOOP_HOME=/usr/local/hadoop \
    HADOOP_CONF_DIR=/etc/hadoop/conf \
    HADOOP_LIBEXEC_DIR=/usr/local/hadoop/libexec \
    HIVE_HOME=/usr/local/hive \
    HIVE_CONF_DIR=/etc/hive/conf \
    DERBY_INSTALL=/usr/local/derby \
    DERBY_HOME=/usr/local/derby \
    JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk \
    PATH=$PATH:/usr/local/hive/bin:/usr/local/hadoop/bin:/usr/local/hadoop/sbin

RUN yum install java-1.8.0-openjdk-devel net-tools -y && \
    cd /usr/local/ && \
    curl -o apache-hive-2.3.7-bin.tar.gz https://downloads.apache.org/hive/hive-2.3.7/apache-hive-2.3.7-bin.tar.gz && \
    tar xzf apache-hive-2.3.7-bin.tar.gz && \
    rm -rf apache-hive-2.3.7-bin.tar.gz && \
    ln -s apache-hive-2.3.7-bin hive && \
    mkdir /etc/hive/ && cp -R /usr/local/hive/conf/ /etc/hive && \
    curl -o hadoop-2.10.0.tar.gz https://downloads.apache.org/hadoop/common/hadoop-2.10.0/hadoop-2.10.0.tar.gz && \
    tar xzf hadoop-2.10.0.tar.gz && \
    chown -R root:root hadoop-2.10.0 && \
    rm -rf hadoop-2.10.0.tar.gz && \
    ln -s hadoop-2.10.0 hadoop && \
    mkdir /etc/hadoop/ && cp -R /usr/local/hadoop/etc/hadoop/ /etc/hadoop/conf/ && \
    curl -o db-derby-10.14.2.0-bin.tar.gz https://apache.mirrors.benatherton.com/db/derby/db-derby-10.14.2.0/db-derby-10.14.2.0-bin.tar.gz && \
    tar xzf db-derby-10.14.2.0-bin.tar.gz && \
    rm -rf db-derby-10.14.2.0-bin.tar.gz && \
    ln -s db-derby-10.14.2.0-bin derby

COPY appconfig.tgz /opt/configscripts/appconfig.tgz
