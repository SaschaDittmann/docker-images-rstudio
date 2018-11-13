FROM rocker/rstudio-stable:3.4.3
MAINTAINER info@bytesmith.de

ENV LC_ALL=en_US.UTF-8 \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		apt-utils \
		bash-completion \
		ca-certificates \
		curl \
		file \
		fonts-texgyre \
		g++ \
		gfortran \
		gsfonts \
		less \
		libbz2-1.0 \
		libcurl3 \
		libgomp1 \
		libopenblas-dev \
		libpango1.0-0 \
		libpcre3 \
		libpng16-16 \
		libtiff5 \
		liblzma5 \
		libsm6 \
		libxt6 \
		locales \
		make \
		unzip \
		wget \
		zip \
		zlib1g \
	&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8 \
	&& ln -s /usr/lib/x86_64-linux-gnu/libpng16.so.16.28.0 /usr/lib/x86_64-linux-gnu/libpng12.so.0 \
	&& rm -rf /tmp/* \
	&& apt-get autoremove -y \
	&& apt-get autoclean -y \
	&& rm -rf /var/lib/apt/lists/*

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

RUN . /etc/os-release \
	&& AZ_REPO=$(lsb_release -cs) \
	&& echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list \
	&& apt-get update \
	&& apt-get install -y gnupg2
	&& apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893 \
	&& apt-get update \
	&& apt-get install -y azure-cli \
		microsoft-mlserver-packages-r-9.3.0 \
		microsoft-mlserver-mml-r-9.3.0 \
		microsoft-mlserver-mlm-r-9.3.0 \
	&& /opt/microsoft/mlserver/9.3.0/bin/R/activate.sh -a -l \
	&& rm -rf /tmp/* \
	&& apt-get autoremove -y \
	&& apt-get autoclean -y \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "# Server Configuration File" > /etc/rstudio/rserver.conf && echo "" >> /etc/rstudio/rserver.conf && echo "rsession-which-r=/opt/microsoft/mlserver/9.3.0/bin/R/R" >> /etc/rstudio/rserver.conf && echo "R_LIBS_SITE='/opt/microsoft/mlserver/9.3.0/libraries/RServer:/opt/microsoft/mlserver/9.3.0/runtime/R/share:/opt/microsoft/rclient/3.4.3/runtime/R/share:/opt/microsoft/ropen/3.4.3/share:/usr/local/lib/R/share'" >> /opt/microsoft/mlserver/9.3.0/runtime/R/etc/Renviron
