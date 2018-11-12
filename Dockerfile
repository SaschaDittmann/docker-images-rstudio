FROM rocker/rstudio-stable:3.4.3
MAINTAINER info@bytesmith.de

ENV LC_ALL=en_US.UTF-8 \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8

RUN apt-get update \
		&& apt-get install -y --no-install-recommends \
			apt-transport-https \
		&& cd /tmp \
		&& wget http://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
		&& dpkg -i packages-microsoft-prod.deb \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		microsoft-r-client-packages-3.4.3 \
	&& rm -rf /tmp/* \
		&& apt-get autoremove -y \
		&& apt-get autoclean -y \
		&& rm -rf /var/lib/apt/lists/*
RUN echo "# Server Configuration File" > /etc/rstudio/rserver.conf && echo "" >> /etc/rstudio/rserver.conf && echo "rsession-which-r=/usr/bin/Revo64" >> /etc/rstudio/rserver.conf && echo "rsession-ld-library-path=/opt/microsoft/rclient/3.4.3/libraries/RServer" >> /etc/rstudio/rserver.conf && echo "R_LIBS_SITE=/opt/microsoft/rclient/3.4.3/libraries/RServer" >> /opt/microsoft/rclient/3.4.3/runtime/R/etc/Renviron
