FROM qserv/stack:centos_latest
MAINTAINER Fabrice Jammes <fabrice.jammes@in2p3.fr>

USER root
RUN yum install -y git

USER qserv
RUN mkdir -p /home/qserv/src
WORKDIR /home/qserv/src
RUN git clone https://github.com/fjammes/mariadb.git
WORKDIR /home/qserv/src/mariadb

# Install MariaDB dependencies
USER root
RUN yum install -y cmake
# Needed by git and MariaDB build step
RUN yum install -y zlib-devel
# Needed by git
RUN yum install -y gettext
USER qserv
RUN bash -c ". /qserv/stack/loadLSST.bash && eups distrib install git 1.8.5.2"
RUN bash -c ". /qserv/stack/loadLSST.bash && setup -r . && eupspkg -er prep"

USER root
RUN yum install -y libncurses5-devel
# TODO faut il libxml2?
USER qserv
RUN bash -c ". /qserv/stack/loadLSST.bash && setup -r . && eupspkg -er config"

USER root
RUN yum install -y liblzma-devel
USER qserv
RUN bash -c ". /qserv/stack/loadLSST.bash && setup -r . && eupspkg -er build"

USER root
RUN yum install -y vim
USER qserv
RUN bash -c ". /qserv/stack/loadLSST.bash && setup -r . && eupspkg -er install"
RUN bash -c ". /qserv/stack/loadLSST.bash && setup -r . && eupspkg -er decl -t current"
