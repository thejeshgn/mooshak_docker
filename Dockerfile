## -*- docker-image-name: "thejeshgn/mooshak:latest" -*-
##
# Mooshak Server
#

FROM phusion/baseimage:0.9.17
MAINTAINER Thejesh GN <i@thejeshgn.com>

# Install dependencies
RUN apt-get update && apt-get install -y \
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

# Install more dependencies
RUN cd ~ && wget ftp://xmlsoft.org/libxml2/libxml2-2.9.1.tar.gz
RUN cd ~ && tar xzf libxml2-2.9.1.tar.gz && cd ~/libxml2-2.9.1 && \
		./configure  && \
		make && make install
RUN ln -s /usr/local/bin/xmllint /usr/bin/xmllint

# Install mooshak
RUN cd ~ && wget --no-check-certificate http://mooshak.dcc.fc.up.pt/download/mooshak-1.6b15.tgz
RUN cd ~ && tar xzf mooshak.tgz && cd ~/mooshak-1.6b13 && \
		./install --user mooshak --install

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
ADD run.sh /usr/local/sbin/run
ENTRYPOINT ["/sbin/my_init", "--", "/usr/local/sbin/run"]

# Default to showing the usage text
CMD ["help"]