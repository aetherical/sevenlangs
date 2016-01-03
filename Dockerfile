FROM java:openjdk-8-jdk
ENV LEIN_ROOT=true
ENV SCALA_HOME=/usr/local/share/scala-2.11.7
COPY install_bundler /tmp
RUN apt-get update && \
    apt-get -y install wget \
	    curl  && \
    chmod +x /tmp/install_bundler



# ruby, gem, bundler

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.5 && \
    echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc && \
    /tmp/install_bundler

# clojure
RUN curl -o /usr/local/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    chmod +x /usr/local/bin/lein && \
    /usr/local/bin/lein
    
# haskell
RUN apt-get -y install haskell-platform

# rust
RUN curl -o /tmp/rustup.sh -sSf https://static.rust-lang.org/rustup.sh && \
    sh /tmp/rustup.sh -y --disable-sudo 

# scala
RUN cd /usr/local/share && \
    curl http://downloads.typesafe.com/scala/2.11.7/scala-2.11.7.tgz | tar xzvfBp - && \
    echo 'PATH=/usr/local/share/scala-2.11.7/bin:$PATH' >> /etc/bash.bashrc && \
    wget -qO- https://dl.bintray.com/sbt/native-packages/sbt/0.13.9/sbt-0.13.9.tgz|tar xzvfBp - && \
    echo 'PATH=/usr/local/share/sbt/bin:$PATH' >> /etc/bash.bashrc

# elixir
RUN cd && \
    wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb &&\
    dpkg -i erlang-solutions_1.0_all.deb && \
    apt-get update && \
    apt-get install -y esl-erlang elixir 

# Go
RUN cd /usr/local && \
    curl https://storage.googleapis.com/golang/go1.5.2.linux-amd64.tar.gz | tar xzvfBp - && \
    echo 'PATH=/usr/local/go/bin:$PATH' >> /etc/bash.bashrc

RUN mkdir /work
VOLUME ["/work"]
ENTRYPOINT ["/bin/bash"]    
    
    

    
