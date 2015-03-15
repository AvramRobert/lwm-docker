FROM fedora:21

MAINTAINER Robert Marius Avram <am11.robert@yahoo.com>

#basics
RUN su 
RUN yum -y install wget && yum -y install tar && yum -y install curl
RUN su -c 'yum localinstall -y --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'

#get java
RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.tar.gz
RUN tar -xvf jdk-8u31-linux-x64.tar.gz && mv jdk1.8.0_31 java && mv ./java /usr/ && rm jdk-8u31-linux-x64.tar.gz

#set java
RUN ln -rs /usr/java/bin/java /usr/bin/java
RUN ln -rs /usr/java/bin/javac /usr/bin/javac

VOLUME /lwm

ENTRYPOINT /lwm/activator run
