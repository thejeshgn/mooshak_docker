## -*- docker-image-name: "thejeshgn/mooshak:latest" -*-
##
# Mooshak Server
#

FROM phusion/baseimage:0.9.17
MAINTAINER Thejesh GN <i@thejeshgn.com>

# Install dependencies
RUN apt-get update -y && apt-get install -y \
	vim \
	gcc \
	make \
	tcl \
	apache2 \
	apache2-suexec \
	xsltproc \
	lpr \
	time \
	host \
	wget \
	rsync \
	time \
	gnuspool \
	diffutils \
	gnome-schedule \
	file \
	xsltproc \
	libxml2-utils \
	nano \
	lynx 

RUN cd /etc/apache2/mods-enabled && sudo ln -s ../mods-available/userdir.conf &&\
	sudo ln -s ../mods-available/userdir.load \
	sudo ln -s ../mods-available/suexec.load	

# Install mooshak
#RUN cd ~ && wget --no-check-certificate http://mooshak.dcc.fc.up.pt/download/mooshak-1.6.2.tgz
#RUN cd ~ && tar xzf mooshak-1.6.2.tgz && cd ~/mooshak-1.6.2 && \
#		./install --user mooshak --install

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# open the ports 
EXPOSE 80 22

# Add the README
ADD README.md /usr/local/share/doc/

# Add the help file
RUN mkdir -p /usr/local/share/doc/run
ADD help.txt /usr/local/share/doc/run/help.txt



# Enable SSH
RUN rm -f /etc/service/sshd/down
## Install an SSH of your choice. where your key is your_key.pub
ADD your_key.pub /tmp/your_key.pub
RUN cat /tmp/your_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/your_key.pub



# Add the entrypoint
#ADD run.sh /usr/local/sbin/run
#ADD run.sh /etc/service/run

#ENTRYPOINT ["/sbin/my_init", "--", "/usr/local/sbin/run"]

# Default to showing the usage text
#CMD ["help"]
CMD ["/sbin/my_init"]
