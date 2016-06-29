FROM debian:jessie

RUN echo "===> Install Java 7" \
 && echo "==> add webupd8 repository..." \
 && echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
 && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
 && apt-get update \
 && echo "==> install Java..." \
 && echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
 && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes oracle-java7-installer oracle-java7-set-default maven \
 && echo "==> clean up..." \
 && rm -rf /var/cache/oracle-jdk7-installer \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV MAVEN_VERSION=3.3.9
RUN echo "===> Install Maven $MAVEN_VERSION" \
 && mkdir -p /usr/local/apache-maven \
 && wget http://mirror.dkd.de/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
 && mv apache-maven-$MAVEN_VERSION-bin.tar.gz /usr/local/apache-maven \
 && cd /usr/local/apache-maven \
 && tar -xzvf apache-maven-$MAVEN_VERSION-bin.tar.gz \
 && rm apache-maven-$MAVEN_VERSION-bin.tar.gz \
 && echo "==> symlink" \
 && ln -s /usr/local/apache-maven/apache-maven-$MAVEN_VERSION/bin/mvn /usr/local/bin/mvn

ENV SCALA_TARBALL=http://www.scala-lang.org/files/archive/scala-2.11.6.deb
ENV SCALA_VERSION=2.11.6
RUN echo "===> Install Scala $SCALA_VERSION" \
 && echo "==> install curl helper tool..." \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes curl \
 && echo "==> install from Typesafe repo (contains old versions but they have all dependencies we need later on)" \
 && curl -sSL http://apt.typesafe.com/repo-deb-build-0002.deb -o repo-deb.deb \
 && dpkg -i repo-deb.deb \
 && apt-get update \
 && echo "==> install Scala" \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes libjansi-java \
 && curl -sSL $SCALA_TARBALL -o scala.deb \
 && dpkg -i scala.deb \
 && echo "==> clean up..." \
 && rm -f *.deb \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /work
COPY _bashrc /root/.bashrc
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]


