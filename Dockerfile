## This is for Deploy R Open testing

## Use CentOS 6  as basis for container
FROM centos:centos6

MAINTAINER "Stephen Weller" stephen.weller@revolutionanalytics.com

## Start in /root, not / so checkpoint package does not attempt to scan whole file system.
WORKDIR /root

RUN yum update -y \
&& yum install -y tar nano sudo nfs-utils-lib curl wget perl java-1.7.0-openjdk-devel cairo-devel libpng-devel tk-devel libicu libXt-devel readline readline-devel glibc-devel gcc gcc-gfortran gcc-c++ make ed

## Test with CRAN R 3.1.1
RUN wget http://cran.revolutionanalytics.com/src/base/R-3/R-3.1.1.tar.gz \
&& tar xzf R-3.1.1.tar.gz \
&& R-3.1.1/configure --enable-R-shlib --with-tcltk --with-cairo --with-libpng \
&& make \
&& make install

## End of root user operations

# Now add a non-root user to install DeployR Open
RUN useradd deployr-user \
&& sudo su - deployr-user

RUN mkdir $HOME/Downloads \
&& cd $HOME/Downloads \
&& wget http://seajenkins.revolution-computing.com/job/DeployR-Trunk-xPlatform-Core/lastSuccessfulBuild/artifact/buildArtifacts/DeployR-Open-Linux-7.4.0.tar.gz \
&& tar xzf DeployR-Open-Linux-7.4.0.tar.gz
